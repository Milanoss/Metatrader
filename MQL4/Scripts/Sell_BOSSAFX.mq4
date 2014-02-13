//+------------------------------------------------------------------+
//|                                                 Sell_BOSSAFX.mq4 |
//|                                                    Damian Jozwik |
//|                                                   www.bossafx.pl |
//+------------------------------------------------------------------+
#property copyright "BOSSAFX"
#property link      "www.bossafx.pl"

//27.11.2012

#include <stdlib.mqh>
#include <stderror.mqh>





 double           Hodnota_transakce=1       ;

 int              Stop_loss=30               ;

 int              Take_profit=50             ;

 int              Maximální_odchylka_od_ceny=2   ;             


 
































//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {

            double Lot=Hodnota_transakce;
            int price_dev=Maximální_odchylka_od_ceny;                       
            double TP=0;
            double SL=0;
                        
            if( Take_profit!= 0 )  TP=MarketInfo(Symbol(),MODE_BID)-Take_profit*Point;
            if( Stop_loss !=0 )    SL=MarketInfo(Symbol(),MODE_ASK)+Stop_loss*Point;
            
            int cmd;
            int blad;
  
           
            double max_lot=MarketInfo(Symbol(),MODE_MAXLOT);
            int order_ticket;
 
            
                 while( Lot >0 )
                 {  
                     if ( Lot > max_lot)
                     {
                        cmd=OrderSend(Symbol(),OP_SELL,max_lot,MarketInfo(Symbol(),MODE_BID),price_dev,SL,TP);     //otwarcie pozycji krótkiej
                        Lot=Lot-max_lot;
                     }
                     else
                     {
                       cmd=OrderSend(Symbol(),OP_SELL,Lot,MarketInfo(Symbol(),MODE_BID),price_dev,SL,TP);
                       Lot=0;
                     }
                      
                    
                      if (cmd == -1)        // w przypadku gdy zlecenie nie zostanie otwarte sprawdzamy  
                      {                                // co mog³o spowodowaæ b³ad
                             blad=GetLastError();
                             switch(blad)
                             { 
                              case 4109:
                                   Alert(" Opcja \"Umo¿liw handel\" jest wy³¹czona. ");
                                                      
                              break;
                              case 134:
                                   Alert(" Niewystarczaj¹ca iloœæ wolnych œrodków do otwarcia zlecenia.");
                               
                              break;
                              default: 
                                   Alert("Wyst¹pi³ b³¹d numer: ",blad,"  \"",ErrorDescription(blad),"\"");
                             
                             }
                          break;
                      }
                     
                 }                                           
   return(0);
  }
//+------------------------------------------------------------------+


                 

