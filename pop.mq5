//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property description "Power of Prices"
#property icon "\\Images\\Aha-Soft-Free-Large-Boss-Devil.ico"
#property version "1.0"
input uint number_of_previous_days = 100; // How many days to look back to?
input ENUM_TIMEFRAMES user_period_of_choice = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| All important variables bellow 🔽🔽🔽.     
//+------------------------------------------------------------------+
uint calculation_seconds = PeriodSeconds(user_period_of_choice);
uint number_of_previous_candles = (number_of_previous_days * 24 * 3600) / calculation_seconds;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {
   EventSetTimer(calculation_seconds); //initialises and sets our timer intervals. very important.
   Print(number_of_previous_candles); // just for information.
   
   for(int i=0;i<SymbolsTotal(1);i++)
     {
      Print("SYMBOL: ",SymbolName(i,2)," Found At: ",i);
     }
   
   
   Init_myLine();
   Print("You are using ", __FILE__, " version 0.2");
   printf("ACCOUNT_BALANCE =  %G", AccountInfoDouble(ACCOUNT_BALANCE));
   printf("ACCOUNT_CREDIT =  %G", AccountInfoDouble(ACCOUNT_CREDIT));
   printf("ACCOUNT_PROFIT =  %G", AccountInfoDouble(ACCOUNT_PROFIT));
   printf("ACCOUNT_EQUITY =  %G", AccountInfoDouble(ACCOUNT_EQUITY));
   printf("ACCOUNT_MARGIN =  %G", AccountInfoDouble(ACCOUNT_MARGIN));
   printf("ACCOUNT_MARGIN_FREE =  %G", AccountInfoDouble(ACCOUNT_MARGIN_FREE));
   printf("ACCOUNT_MARGIN_LEVEL =  %G", AccountInfoDouble(ACCOUNT_MARGIN_LEVEL));
   printf("ACCOUNT_MARGIN_SO_CALL = %G", AccountInfoDouble(ACCOUNT_MARGIN_SO_CALL));
   printf("ACCOUNT_MARGIN_SO_SO = %G", AccountInfoDouble(ACCOUNT_MARGIN_SO_SO));
   return(INIT_SUCCEEDED);
}
//+----------------------------------------------------------------------------------+
//|
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick() {
   my_comments();
   double price_ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK); // get price ask.
   ObjectMove(_Symbol, "Line1", 0, 0, 1.07); // draw line
   array_of_previous_prices(number_of_previous_candles);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Init_myLine() {
   ObjectCreate(
      _Symbol,
      "Line1",
      OBJ_HLINE,
      0, //int sub_window
      0, //datetime time1
      0 // y value on chart
   );
   ObjectSetInteger(
      0, // long chart_id
      "Line1",
      OBJPROP_COLOR, //int properti_modifier
      clrBlack       // long value
   );
   ObjectSetInteger(0, "Line1", OBJPROP_WIDTH, 6); // line width.
}
//+------------------------------------------------------------------+
void OnTimer() {
   
}

//+------------------------------------------------------------------+
//| Array of previous prices
//+------------------------------------------------------------------+
void array_of_previous_prices(uint number_of_previous_candles) {
}
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void my_comments() {
//+------------------------------------------------------------------+
//|      obtain spread from the symbol properties
//+------------------------------------------------------------------+
   bool spreadfloat = SymbolInfoInteger(Symbol(), SYMBOL_SPREAD_FLOAT);
   string spread_comment = StringFormat("Spread %s = %I64d points\r\n",
                                        spreadfloat ? "floating" : "fixed",
                                        SymbolInfoInteger(Symbol(), SYMBOL_SPREAD));
//--- now let's calculate the spread by ourselves
   double ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
   double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   double spread = ask - bid;
   int spread_points = (int)MathRound(spread / SymbolInfoDouble(Symbol(), SYMBOL_POINT));
   spread_comment = spread_comment + "Calculated spread = " + (string)spread_points +  " points";
//+------------------------------------------------------------------+
   Comment(spread_comment +
           "\n" + "new line" +
           "\n" + "candles are this big => " + (int)PeriodSeconds(user_period_of_choice) / 3600 + " hours");
}
//+------------------------------------------------------------------+
