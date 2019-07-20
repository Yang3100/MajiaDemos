//
//  KJEquipmentVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/10.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJEquipmentVC.h"
#import "NetworkTools.h"
#import "KJEquipmentCell.h"
#import "KJEquipmentModel.h"

@interface KJEquipmentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSArray *temps;
@end

@implementation KJEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Equipment";
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    [self.mainTable registerNib:[UINib nibWithNibName:@"KJEquipmentCell" bundle:nil] forCellReuseIdentifier:@"KJEquipmentCell"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    KJEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJEquipmentCell" forIndexPath:indexPath];
    cell.model = self.temps[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.temps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSArray*)temps{
    if (!_temps) {
        NSDictionary *infoDic = [NetworkTools getDinfo];
        NSLog(@"%@", infoDic);
        KJEquipmentModel *model1 = [[KJEquipmentModel alloc]init];
        model1.name = @"Equipment";
        model1.sub_name = infoDic[@"decice_name"];
        
        KJEquipmentModel *model2 = [[KJEquipmentModel alloc]init];
        model2.name = @"Name";
        model2.sub_name = infoDic[@"device_info"];
        
        KJEquipmentModel *model3 = [[KJEquipmentModel alloc]init];
        model3.name = @"Version";
        model3.sub_name = infoDic[@"system_version"];
        
        KJEquipmentModel *model4 = [[KJEquipmentModel alloc]init];
        model4.name = @"Screen Height";
        model4.sub_name = infoDic[@"rh"];
        
        KJEquipmentModel *model5 = [[KJEquipmentModel alloc]init];
        model5.name = @"Screen Width";
        model5.sub_name = infoDic[@"rw"];
        
        KJEquipmentModel *model6 = [[KJEquipmentModel alloc]init];
        model6.name = @"Resolution";
        model6.sub_name = [NSString stringWithFormat:@"%dx%d",[infoDic[@"rw"] intValue]*3,[infoDic[@"rh"] intValue]*3];
        
        KJEquipmentModel *model7 = [[KJEquipmentModel alloc]init];
        model7.name = @"Memory";
        model7.sub_name = infoDic[@"available_memory"];
        
        KJEquipmentModel *model8 = [[KJEquipmentModel alloc]init];
        model8.name = @"Free";
        model8.sub_name = infoDic[@"available_disk"];
        
        KJEquipmentModel *model9 = [[KJEquipmentModel alloc]init];
        model9.name = @"IP";
        model9.sub_name = infoDic[@"ip"];
        
        KJEquipmentModel *model10 = [[KJEquipmentModel alloc]init];
        model10.name = @"udid";
        model10.sub_name = infoDic[@"udid"];
        _temps = @[model1,model2,model3,model5,model4,model6,model7,model8,model9,model10];
    }
    return _temps;
}

@end
