
#import "ViewController.h"
#import "ASStudent.h"

@interface ViewController ()
@property (strong,nonatomic)  NSMutableArray* learnerArray;
@property (strong, nonatomic) NSMutableArray* arrayStudents;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayStudents = [[NSMutableArray alloc] init];
    self.learnerArray  = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<=25; i++) {
        
        ASStudent* obj = [[ASStudent alloc] init];
        [self.arrayStudents addObject:obj];
    }
    
    NSMutableArray* studentsStudyingFive  = [[NSMutableArray alloc] init];
    NSMutableArray* studentsStudyingFour  = [[NSMutableArray alloc] init];
    NSMutableArray* studentsStudyingThree = [[NSMutableArray alloc] init];
    NSMutableArray* studentsStudyingTwo   = [[NSMutableArray alloc] init];

    
    
    
    for (ASStudent  *obj in self.arrayStudents){
        
        if (obj.gpa < 3) {
            [studentsStudyingTwo addObject:obj];
        }
        else
            if (obj.gpa < 4) {
            [studentsStudyingThree addObject:obj];
        }
        else
            if (obj.gpa < 5) {
            [studentsStudyingFour addObject:obj];
        }
        else
            if (obj.gpa < 6) {
            [studentsStudyingFive addObject:obj];
        }
        
     }
    
     self.learnerArray = [NSMutableArray arrayWithObjects:studentsStudyingFive,studentsStudyingFour,studentsStudyingThree,studentsStudyingTwo, nil];
    
     // Сортировка
    
    for (int i=0; i <= [self.learnerArray count]-1; i++) {
        
     NSMutableArray* arr = [NSMutableArray new];
     arr  = [self.learnerArray objectAtIndex:i];
     arr  = [self sortingArray:arr];
     [self.learnerArray replaceObjectAtIndex:i withObject:arr];
    }
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.learnerArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.learnerArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* indentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }

    
    NSString* name   = [[[self.learnerArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]   name];
    NSString* famaly = [[[self.learnerArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] famaly];
    double    gpa    = [[[self.learnerArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]   gpa];
    
    cell.textLabel.text       = [NSString stringWithFormat:@"%@ %@",name,famaly];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ",gpa];
    
    cell.backgroundColor = [self colorForSection:indexPath];
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSArray* namesSection = [NSArray arrayWithObjects:@"Отличники",@"Хорошисты",@"Троечники",@"Двоичники", nil];
    
    if ([namesSection count] == [self.learnerArray count]) {
        return [namesSection objectAtIndex:section];
    }
    
    return @"Fake!";
}



-(UIColor*) colorForSection:(NSIndexPath*) indexPath {
    
    NSArray* array = [NSArray arrayWithObjects:[UIColor greenColor],[UIColor yellowColor],
                                               [UIColor orangeColor],[UIColor redColor], nil];
    
    return [array objectAtIndex:indexPath.section];
}




-(NSMutableArray*) sortingArray:(NSMutableArray*) arr {
    
    
    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *secondDescriptor = [[NSSortDescriptor alloc] initWithKey:@"famaly" ascending:YES];
    
    NSMutableArray *sortDescriptors = [NSMutableArray arrayWithObjects:firstDescriptor, secondDescriptor, nil];
    
    NSMutableArray *sortedArray = [arr sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
