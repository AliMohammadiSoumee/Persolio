//
//  DBModel.m
//  Prediscore
//
//  Created by Hamidreza Vaklian on 5/26/16.
//  Copyright © 2016 pxlmind. All rights reserved.
//

#import "DBModel.h"
#import "helper.h"
#import "Codebase.h"
#import <sqlite3/sqlite3.h>
//#import "Codebase_definitions.h"

#define core_db_version	110

@implementation DBModel

+(sqlite3*)get_db
{
    static sqlite3* db;
    
    if (db)
        return db;
	
	[helper makeSqliteThreadSafeIfNeeded];
	
    if ([helper_file pathExistInDocumentsDIR:@"essentials.sqlite"])
    {
        NSString* file_path = [helper_file pathInDocumentDIR:@"essentials.sqlite"];
        
        if (sqlite3_open([file_path UTF8String], &db) == SQLITE_OK)
		{
			///////
			BOOL shouldReplaceNewSqliteFile = YES;
			NSString *query = @"SELECT * FROM `option` WHERE `key` = 'db_version'";
			sqlite3_stmt *statement;
			if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
				while (sqlite3_step(statement) == SQLITE_ROW) {
						int64_t intVal = sqlite3_column_int64(statement, 2);
						if (intVal >= core_db_version)
							shouldReplaceNewSqliteFile = NO;
				}
				
				sqlite3_finalize(statement);
			}
			
			if (shouldReplaceNewSqliteFile)
			{
				
				sqlite3_close(db);
				NSString* template_file_path = [[helper theBundle] pathForResource:@"essentials" ofType:@"sqlite"];
				NSString* dest_path = [helper_file pathInDocumentDIR:@"essentials.sqlite"];
				
				NSError* error;
				
				[[NSFileManager defaultManager] removeItemAtPath:dest_path error:&error];

				if (error)
				{
					NSLog(@"could not delete old sqlite file: %@", error);
					return nil;
				}
				
				if (![[NSFileManager defaultManager] copyItemAtPath:template_file_path toPath:dest_path error:&error])
				{
					NSLog(@"error copying the database from bundle: %@", error);
				}
				else //successful copying of database file
				{
					if (sqlite3_open([dest_path UTF8String], &db) == SQLITE_OK)
						return db;
					else //error
					{
						NSLog(@"Failed to open database!");
						return nil;
					}
				}

			}
			else
				return db;
		}
        else //error
        {
            NSLog(@"Failed to open database!");
            return nil;
        }
    }
    else //file not exists so copy if from the bundle
    {
        NSString* template_file_path = [[helper theBundle] pathForResource:@"essentials" ofType:@"sqlite"];
        NSString* dest_path = [helper_file pathInDocumentDIR:@"essentials.sqlite"];
        
        NSError* error;
        if (![[NSFileManager defaultManager] copyItemAtPath:template_file_path toPath:dest_path error:&error])
        {
            NSLog(@"error copying the database from bundle: %@", error);
        }
        else //successful copying of database file
        {
            if (sqlite3_open([dest_path UTF8String], &db) == SQLITE_OK)
                return db;
            else //error
            {
                NSLog(@"Failed to open database!");
                return nil;
            }
        }
    }
    
    return nil;
}

+ (BOOL)purgeTable
{
	NSString *deleteSQL = _strfmt(@"DELETE FROM `Essentials`");
	sqlite3_stmt *statement;
	sqlite3_prepare_v2([DBModel get_db], [deleteSQL UTF8String], -1, &statement, NULL);
	if (sqlite3_step(statement) == SQLITE_DONE)
		return true;
	else
		return false;
}

+(BOOL)deleteValueForKey:(NSString*)key
{
    NSString *deleteSQL = _strfmt(@"DELETE FROM `option` WHERE `key` = '%@'", key);
    sqlite3_stmt *statement;
    sqlite3_prepare_v2([DBModel get_db], [deleteSQL UTF8String], -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
        return true;
    else
        return false;
}

+(BOOL)deleteAllPermissions
{
	NSString *deleteSQL = @"DELETE FROM `permission`";
	sqlite3_stmt *statement;
	sqlite3_prepare_v2([DBModel get_db], [deleteSQL UTF8String], -1, &statement, NULL);
	if (sqlite3_step(statement) == SQLITE_DONE)
		return true;
	else
		return false;
}

+(BOOL)hasPermission:(NSString *)permission
{
	NSString *query = _strfmt(@"SELECT * FROM `permission` WHERE `permission` = '%@'", permission);
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2([DBModel get_db], [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
		while (sqlite3_step(statement) == SQLITE_ROW) {
			char *type_cstr = (char *) sqlite3_column_text(statement, 0);
			NSString* type_str = [NSString stringWithCString:type_cstr encoding:NSUTF8StringEncoding];
			if ([type_str isEqualToString:permission])
				return true;
			else
				return false;
		}
		sqlite3_finalize(statement);
	}
	
	return false;
}

+(BOOL)addPermission:(NSString*)value
{
	NSString *insertSQL = @"INSERT OR REPLACE INTO `permission` (`permission`) VALUES (?)";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2([DBModel get_db], [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
	{
		if(sqlite3_bind_text(statement, 1, [value UTF8String], -1, NULL) == SQLITE_OK)
		{
			if (sqlite3_step(statement) == SQLITE_DONE)
				return true;
			else
				return false;
		}
		else
			NSLog(@"begayi zamane insert kardane string");
	}
	else
		NSLog(@"inja bga raftim 34314");
	
	return false;
}

+(BOOL)updateValue:(id)value forKey:(NSString *)key
{
    if ([value isKindOfClass:[NSString class]])
    {
        NSString *insertSQL = _strfmt(@"INSERT OR REPLACE INTO `option` (`key`, `type`, `stringValue`) VALUES ('%@', '%@', ?)", key, @"str");
            sqlite3_stmt *statement;
		if (sqlite3_prepare_v2([DBModel get_db], [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
		{
			if(sqlite3_bind_text(statement, 1, [value UTF8String], -1, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_DONE)
					return true;
				else
					return false;
			}
			else
				NSLog(@"begayi zamane insert kardane string");
		}
		else
			NSLog(@"inja bga raftim 34314");
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
		if (strcmp([value objCType], @encode(double)) == 0 || strcmp([value objCType], @encode(float)) == 0)
		{
			NSString *insertSQL = _strfmt(@"INSERT OR REPLACE INTO `option` (`key`, `type`, `doubleValue`) VALUES ('%@', '%@', %@)", key, @"dbl", value);
			sqlite3_stmt *statement;
			if (sqlite3_prepare_v2([DBModel get_db], [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_DONE)
					return true;
				else
					return false;
			}
			else
				NSLog(@"inja bga raftim 3434234234");
			
			
		}
		else if (strcmp([value objCType], [@(YES) objCType]) == 0)
		{
			NSString *insertSQL = _strfmt(@"INSERT OR REPLACE INTO `option` (`key`, `type`, `boolValue`) VALUES ('%@', '%@', %@)", key, @"bool", [value boolValue] ? @"1" : @"0");
			sqlite3_stmt *statement;
			if (sqlite3_prepare_v2([DBModel get_db], [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_DONE)
					return true;
				else
					return false;
			}
			else
				NSLog(@"inja bga raftim 3434xcv");
		}
		else
		{
			NSString *insertSQL = _strfmt(@"INSERT OR REPLACE INTO `option` (`key`, `type`, `intValue`) VALUES ('%@', '%@', %@)", key, @"int", value);
			sqlite3_stmt *statement;
			if (sqlite3_prepare_v2([DBModel get_db], [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_DONE)
					return true;
				else
					return false;
			}
			else
				NSLog(@"inja bga raftim 3434");
		}
//
//        else
//            NSLog(@"unsupported nsnumber: %@", value);
    }
    else
        NSLog(@"unsupported value class: %@ value:%@", NSStringFromClass([value class]), value);
    
    return false;
}

+(id)getValueForKey:(NSString *)key
{
    id returnVal;
    NSString *query = _strfmt(@"SELECT * FROM `option` WHERE `key` = '%@'", key);
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2([DBModel get_db], [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *type_cstr = (char *) sqlite3_column_text(statement, 1);
            NSString* type_str = [NSString stringWithCString:type_cstr encoding:NSUTF8StringEncoding];
            if ([type_str isEqualToString:@"int"])
            {
                int64_t intVal = sqlite3_column_int64(statement, 2);
                returnVal = @(intVal);
            }
            else if ([type_str isEqualToString:@"str"])
            {
                char* strVal = (char *) sqlite3_column_text(statement, 3);
                returnVal = [NSString stringWithCString:strVal encoding:NSUTF8StringEncoding];
            }
            else if ([type_str isEqualToString:@"dbl"])
            {
                double doubleVal = sqlite3_column_double(statement, 4);
                returnVal = @(doubleVal);
            }
			else if ([type_str isEqualToString:@"bool"])
			{
				bool boolVal = sqlite3_column_int(statement, 5);
				returnVal = @(boolVal);
			}
        }
        
        sqlite3_finalize(statement);
    }
    
    return returnVal;
}

@end
