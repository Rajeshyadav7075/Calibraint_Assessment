# Calibraint_Assessment

### ShowViewController 
    This ViewController will be loaded first, which contains SearchBar and TableView Components.
  ##### Variables
     This Class Contains 4 Variables
      *  Search - whether searchbar is activated or not.
      *  Netflix - Data loaded from URL will be stored in the variable.
      *  FilteredData - if searchbar is active, the filtered data will stored in this variable.
      *  API - this is an object for APICallManager Class to access FetchDataFromServer Method
 ##### ShowTableView
    *  This will load list of Netflix Shows available in the [api.tvmaze.com](http://api.tvmaze.com/search/shows?q=netflix) api
    *  Cell Prototype Contains ImageView, Episodes Button, Title and Description
 ##### SearchBar 
    This SearchBar Delegate will filter the data based on keystrokes in the Search field
      *  used higher order function - filter to filter the netflix array  
### APICallManager Class
    This class contains a Generic Function, which will fetchData from url by creating instance for URLSession and instance for dataTask with URL to retrive data from specified URL.
### GlobalAccess Class
    This class contains a function which will replace HTML tags with empty string from description. this function doesnot require any instance to call as this function confirm to (class) and can access within module.
### DetailViewController
    This ViewController will pushed to the navigation stack when user Tap on the episode in ShowViewController

    
