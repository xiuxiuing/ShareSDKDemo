

#import <UIKit/UIKit.h>
#import <SMS_SDK/SMS_SDKResultHanderDef.h>

@protocol CustomCellDelegate;

@interface SectionsViewControllerFriends : UIViewController
<UITableViewDataSource, UITableViewDelegate,CustomCellDelegate,UISearchBarDelegate>
{
    UITableView *table;
    UISearchBar *search;
    NSDictionary *allNames;
    NSMutableDictionary *names;
    NSMutableArray  *keys;    
    
    BOOL    isSearching;
}
@property (nonatomic, strong)  UITableView *table;
@property (nonatomic, strong)  UISearchBar *search;
@property (nonatomic, strong) NSDictionary *allNames;
@property (nonatomic, strong) NSMutableDictionary *names;
@property (nonatomic, strong) NSMutableArray *keys;
- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@property(nonatomic,strong) UIWindow* window;


-(void)setMyData:(NSMutableArray*) array;

-(void)setMyBlock:(ShowNewFriendsCountBlock)block;

@property(nonatomic,strong) ShowNewFriendsCountBlock friendsBlock;

@end

