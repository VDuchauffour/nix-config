{
  Default = "DuckDuckGo";
  SearchSuggestEnabled = false;
  Remove = ["Google" "Bing" "Amazon.com" "eBay" "Wikipedia"];
  PreventInstalls = false;
  Add = [
    {
      Name = "DuckDuckGo";
      URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
      Alias = "ddgr";
    }
    {
      Name = "Google";
      URLTemplate = "https://google.com/?q={searchTerms}";
      Alias = "google";
    }
  ];
}
