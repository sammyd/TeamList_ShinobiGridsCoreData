//
//  SdataGridImageCell.m
//  TeamList
//
//  Created by Sam Davies on 06/06/2013.
//  Copyright (c) 2013 Shinobi Controls. All rights reserved.
//

#import "SdataGridImageCell.h"

@implementation SdataGridImageCell {
    UIImageView *imageView;
}

- (id)initWithReuseIdentifier:(NSString *)identifier
{
    self = [super initWithReuseIdentifier:identifier];
    if(self) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    if(image != _image) {
        _image = image;
        imageView.image = image;
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    imageView.frame = self.bounds;
}

@end
