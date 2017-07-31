//
//  _tableViewCellBase.m
//  mactehrannew
//
//  Created by hAmidReza on 5/1/17.
//  Copyright © 2017 archibits. All rights reserved.
//

#import "_tableViewCellBase.h"

@implementation _tableViewCellBase

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		self.clipsToBounds = YES;
		[self initialize];
	}
	return self;
}

-(void)configureWithDictionary:(NSMutableDictionary*)dic
{
	
}

-(void)initialize
{
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString*)reuseIdentifier
{
	static NSString* cellReuseIdentifier;
	if (!cellReuseIdentifier)
	cellReuseIdentifier = NSStringFromClass([self class]);
	return cellReuseIdentifier;
}

@end
