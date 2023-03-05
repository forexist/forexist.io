   Print("The expert with name ",MQL5InfoString(MQL5_PROGRAM_PATH)," is running"); 
   Print("The expert with name ",MQL5InfoString(MQL5_PROGRAM_NAME)," is running"); 
   
   
   
   
   
   double val; 
//--- Calculation of the highest Close value among 20 consecutive bars 
//--- From index 4 to index 23 inclusive, on the current timeframe 
   int val_index=iHighest(NULL,0,MODE_CLOSE,20,4); 
   if(val_index!=-1)  
      val=High[val_index]; 
   else  
      PrintFormat("iHighest() call error. Error code=%d",GetLastError());
      
      
      
      
      