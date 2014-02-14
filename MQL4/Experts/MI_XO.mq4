//+------------------------------------------------------------------+
//|                                                        MI_XO.mq4 |
//|                                                         Milanoss |
//|                         https://github.com/Milanoss/SimpleBasket |
//+------------------------------------------------------------------+
#property copyright "Milanoss"
#property link      "https://github.com/Milanoss/SimpleBasket"
#property version   "1.00"
#property strict

#define INDICATOR_NAME "SimpleBasket/I_XO_A_H_MI"
//#define INDICATOR_NAME "I_XO_A_H"

input int boxSize=260;
int ticket;
string ea_name="MI_XO";
int magic=36854;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   double buy2=iCustom(Symbol(),0,INDICATOR_NAME,boxSize,0,1);
   double buy1=iCustom(Symbol(),0,INDICATOR_NAME,boxSize,0,2);

   bool isSellOpen=false;
   bool isBuyOpen=false;
   if(OrderSelect(ticket,SELECT_BY_TICKET)==true)
     {
      if(OrderType()==OP_SELL)
        {
         isSellOpen=true;
        }
      else
        {
         isBuyOpen=true;
        }
     }

//--- UP
   if(buy1==0 && buy2>0)
     {
      if(isSellOpen)
        {
         //--- CLOSE SELL
         OrderClose(ticket,1,Ask,3,Red);
        }
      if(!isBuyOpen)
        {
         //--- BUY
         ticket=OrderSend(Symbol(),OP_BUY,1,Ask,5,0,0,ea_name,magic,0,Blue);
        }
     }
//--- DOWN
   else   if(buy1>0 && buy2==0)
     {
      if(isBuyOpen)
        {
         //--- CLOSE BUY
         OrderClose(ticket,1,Bid,3,Red);
        }
      if(!isSellOpen)
        {
         //--- SELL
         ticket=OrderSend(Symbol(),OP_SELL,1,Bid,5,0,0,ea_name,magic,0,Red);
        }
     }

  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
   double ret=0.0;
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  }
//+------------------------------------------------------------------+
