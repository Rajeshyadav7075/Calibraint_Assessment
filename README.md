# Calibraint_Assessment

### ShowViewController 
This ViewController will be loaded first, which contains SearchBar and TableView Components.
  ##### Variables
     This Class Contains 4 Variables
      *  Search - whether searchbar is activated or not.
      *  Netflix - Data loaded from URL will be stored in the variable.
      *  FilteredData - if searchbar is active, the filtered data will stored in this variable.
      *  API - this is an object for Singleton Class to access FetchDataFromServer Method
 ##### ShowTableView
    This will load list of Netflix Shows available in the [api.tvmaze.com](http://api.tvmaze.com/search/shows?q=netflix) api
 ##### SearchBar 
    This SearchBar Delegate will filter the data based on keystrokes in the Search field
      *  used higher order function - filter to filter an array
      
### APICallManager


    
