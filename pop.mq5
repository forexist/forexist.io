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
input bool print_price_lines = true; // Print price lines?
input uint recalculate_price_lines_intervals = 1;
//+------------------------------------------------------------------+
//| All important variables bellow 🔽🔽🔽.                          |
//+------------------------------------------------------------------+
uint calculation_seconds = PeriodSeconds(user_period_of_choice);
uint number_of_previous_candles = (number_of_previous_days * 24 * 3600) / calculation_seconds;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {
   EventSetTimer(calculation_seconds); //initialises and sets our timer intervals. very important.
   printf("ddd %d ", number_of_previous_candles); // just for information.
   /*
   // This block of code lists all symbols.
   for(int i = 0; i < SymbolsTotal(1); i++) {
      Print("SYMBOL: ", SymbolName(i, 2), " Found At: ", i);
   }
   */
   /*
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
   double point_value = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   string format_string = StringFormat("%%s: point value  = %%.%df", _Digits);
   PrintFormat(format_string, _Symbol, point_value);
   */
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+

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
   ObjectSetInteger(0, "Line1", OBJPROP_WIDTH, 2); // line width.
}
//+------------------------------------------------------------------+
void OnTimer() {
   array_of_previous_prices(number_of_previous_candles);
}
//+------------------------------------------------------------------+
//| Array of previous prices
//+------------------------------------------------------------------+
void array_of_previous_prices(uint number_of_previous_candles) {
}
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
           "\n" + "candles are this big => " + (int)PeriodSeconds(user_period_of_choice) / 3600 + " hours" +
           "\n" + "Copyright symbol\t\x00A9");
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
datetime price_array(uint user_input) {
   /*   both bo;
      bo.close = iClose(_Symbol,PERIOD_D1,user_input);
      bo.open = iOpen(_Symbol,PERIOD_D1,user_input);
      return bo;
   */
   MqlTick price;
   SymbolInfoTick(_Symbol, price);
   return price.time;
}
//+------------------------------------------------------------------+
enum both {
   close,
   open
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double price_ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK); // get price ask.

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void print_pl() {
   Print("");
}

uint FileWriteFloat();

namespace another_namespace {
uint obj_1 = 1;
void OnTick(){
Print("Is this working?");
}
}

namespace other_than_global_namespace {

void OnTick() {
   ObjectMove(_Symbol, "Line1", 0, 0, price_ask); // draw line
   my_comments();
//   Print(obj_1 + obj_2);
   if (print_price_lines) {
      print_pl();
   };
   /*long gogoli;
   Print(ChartGetInteger(0,CHART_SHOW_OHLC,0,gogoli));
   printf("%d",gogoli);
   Print(price_array(500));
   Print("");
   */
}

uint obj_2 = 2;
}
//+------------------------------------------------------------------+
