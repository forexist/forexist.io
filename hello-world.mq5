void OnStart() 
  { 
//--- define character constants 
   int symbol_0='0'; 
   int symbol_9=symbol_0+9; // get symbol '9' 
//--- output values of constants  
   printf("In a decimal form: symbol_0 = %d,  symbol_9 = %d",symbol_0,symbol_9); 
   printf("In a hexadecimal form: symbol_0 = 0x%x,  symbol_9 = 0x%x",symbol_0,symbol_9); 
//--- enter constants into a string 
   string test="";  
   StringSetCharacter(test,0,symbol_0); 
   StringSetCharacter(test,1,symbol_9); 
//--- this is what they look like in a string 
   Print(test); 
  }