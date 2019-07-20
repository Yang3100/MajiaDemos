//
//  KJModelNode.m
//  3dTraffic
//
//  Created by 杨科军 on 2018/11/14.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJModelNode.h"
@interface KJModelNode ()

@end

@implementation KJModelNode

- (instancetype)initNodeFromFileName:(NSString *)fileName{
    if (self=[super init]) {
        // 声明3d场景 - 加载scn文件
        NSString *sceneFilePath = [NSString stringWithFormat:@"art.scnassets/%@.scn",fileName];
        SCNScene *scene = [SCNScene sceneNamed:sceneFilePath];
        
        SCNNode *node = scene.rootNode.childNodes.firstObject;

        // 设置起始位置
        SCNVector3 position = node.presentationNode.position;
        position.x += -0.4;
        position.y += -5;
        position.z += -1.2;
        node.position = position;
        // 角度
        SCNVector3 euler = node.presentationNode.eulerAngles;
        euler.x += 0;
        euler.y += 0;
        euler.z += 0;
        node.eulerAngles = euler;
        // 大小尺寸
        SCNVector3 scale = node.presentationNode.scale;
        scale.x -= 0.96;
        scale.y -= 0.96;
        scale.z -= 0.96;
        node.scale = scale;
        
        //把节点添加到场景
        [self addChildNode:node];
        
        // animate the 3d object - 绕y轴一直旋转
        SCNAction *action = [SCNAction repeatActionForever:[SCNAction rotateByX:0 y:1 z:0 duration:2]];
        [node runAction:action];
    }
    return self;
}

@end

