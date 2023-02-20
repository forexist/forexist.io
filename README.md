
# forexist.io

Let's beat the BAZAAR!

## What is the difference between OnInit and OnStart functions?

## How to specify custom icon for my EA?

This is an example of what you are concerned about:

```c++
#property icon "\\Images\\icon-name.ico"
```

Your file must be placed in the metatrader Images folder.

## How to get prices from previous candles in MQL?

```c++
iClose(_Symbol,PERIOD_D1,candle_index);
```

## Is there any structures or enums to get and save prices and candles infos?

Read about the following:

```c++
struct MqlTick
{
datetime time; // Time of the last prices update
double bid; // Current Bid price
double ask; // Current Ask price
double last; // Price of the last deal (Last)
ulong volume; // Volume for the current Last price
};
```

### Description about this MD readme file

All code blocks are marked with c++ because MD syntax doesn't support MQL.
