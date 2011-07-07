import flash.events.Event;
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFormat;

import Images;
import CutScene;
import CustomSprite;
import TimelineContainer;

class Constants {
  public static var flashWidth = 640;
  public static var flashHeight = 512;

  public static inline var MAIN:Int = 100;

//Objects
  public static inline var ITEM = 200;
  public static inline var TOMB = 001;  
  public static inline var TREE = 105;
  public static inline var PLNT = 007;	
  public static inline var HBED = 008;


//House
  public static inline var HUPL:Int = 400;
  public static inline var HUPC:Int = 500;
  public static inline var HUPR:Int = 600;
  public static inline var HLOL:Int = 401;
  public static inline var DOOR:Int = 501;
  public static inline var HLOR:Int = 601;

  public static inline var HBUL:Int = 800;
  public static inline var HBUC:Int = 900;
  public static inline var HBUR:Int = 1000;
  public static inline var HBLL:Int = 801;
  public static inline var BDOR:Int = 901;
  public static inline var HBLR:Int = 1001;
  public static inline var HLTH:Int = 1100;
  public static inline var MART:Int = 1101;
  public static inline var STRS:Int = 1102;

  public static inline var HOUL:Int = 802;
  public static inline var HOUC:Int = 902;
  public static inline var HOUR:Int = 1002;
  public static inline var HOLL:Int = 803;
  public static inline var ODOR:Int = 903;
  public static inline var HOLR:Int = 1003;

  public static inline var HPUL:Int = 804;
  public static inline var HPUC:Int = 904;
  public static inline var HPUR:Int = 1004;
  public static inline var HPLL:Int = 805;
  public static inline var PDOR:Int = 905;
  public static inline var HPLR:Int = 1005;

  public static inline var HWUL:Int = 906;
  public static inline var HWUC:Int = 1006;
  public static inline var HWUR:Int = 1106;
  public static inline var HWLL:Int = 907;
  public static inline var WDOR:Int = 1007;
  public static inline var HWLR:Int = 1107;

  public static inline var HCUL:Int = 1308;
  public static inline var HCUC:Int = 1408;
  public static inline var HCUR:Int = 1508;
  public static inline var HCLL:Int = 1309;
  public static inline var CDOR:Int = 1409;
  public static inline var HCLR:Int = 1509;

  public static inline var BGM1:Int = 1200;
  public static inline var BGM2:Int = 1300;
  public static inline var BGM3:Int = 1400;
  public static inline var BGM4:Int = 1500;
  public static inline var BGM5:Int = 1201;
  public static inline var BGM6:Int = 1301;
  public static inline var BGM7:Int = 1401;
  public static inline var BGM8:Int = 1501;

  public static inline var OGM1:Int = 1202;
  public static inline var OGM2:Int = 1302;
  public static inline var OGM3:Int = 1402;
  public static inline var OGM4:Int = 1502;
  public static inline var OGM5:Int = 1203;
  public static inline var OGM6:Int = 1303;
  public static inline var OGM7:Int = 1403;
  public static inline var OGM8:Int = 1503;

  public static inline var PGM1:Int = 1204;
  public static inline var PGM2:Int = 1304;
  public static inline var PGM3:Int = 1404;
  public static inline var PGM4:Int = 1504;
  public static inline var PGM5:Int = 1205;
  public static inline var PGM6:Int = 1305;
  public static inline var PGM7:Int = 1405;
  public static inline var PGM8:Int = 1505;

  public static inline var WGM1:Int = 1206;
  public static inline var WGM2:Int = 1306;
  public static inline var WGM3:Int = 1406;
  public static inline var WGM4:Int = 1506;
  public static inline var WGM5:Int = 1207;
  public static inline var WGM6:Int = 1307;
  public static inline var WGM7:Int = 1407;
  public static inline var WGM8:Int = 1507;

  public static inline var E400:Int = 1600;
  public static inline var E401:Int = 1700;
  public static inline var E402:Int = 1800;
  public static inline var E403:Int = 1900;
  public static inline var E404:Int = 2000;
  public static inline var E405:Int = 2100;
  public static inline var E406:Int = 2200;
  public static inline var E407:Int = 2300;

  public static inline var E408:Int = 1601;
  public static inline var E409:Int = 1701;
  public static inline var E410:Int = 1801;
  public static inline var E411:Int = 1901;
  public static inline var E412:Int = 2001;
  public static inline var E413:Int = 2101;
  public static inline var E414:Int = 2201;
  public static inline var E415:Int = 2301;
  public static inline var E416:Int = 1602;
  public static inline var E417:Int = 1702;
  public static inline var E418:Int = 1802;
  public static inline var E419:Int = 1902;
  public static inline var E420:Int = 2002;
  public static inline var E421:Int = 2102;
  public static inline var E422:Int = 2202;
  public static inline var E423:Int = 2302;
  public static inline var E424:Int = 1603;
  public static inline var E425:Int = 1703;
  public static inline var E426:Int = 1803;
  public static inline var E427:Int = 1903;
  public static inline var E428:Int = 2003;
  public static inline var E429:Int = 2103;
  public static inline var E430:Int = 2203;
  public static inline var E431:Int = 2303;
  public static inline var E432:Int = 1604;
  public static inline var E433:Int = 1704;
  public static inline var E434:Int = 1804;
  public static inline var E435:Int = 1904;
  public static inline var E436:Int = 2004;
  public static inline var E437:Int = 2104;
  public static inline var E438:Int = 2204;
  public static inline var E439:Int = 2304;
  public static inline var E440:Int = 1605;
  public static inline var E441:Int = 1705;
  public static inline var E442:Int = 1805;
  public static inline var E443:Int = 1905;
  public static inline var E444:Int = 2005;
  public static inline var E445:Int = 2105;
  public static inline var E446:Int = 2205;
  public static inline var E447:Int = 2305;
  public static inline var E448:Int = 1606;
  public static inline var E449:Int = 1706;
  public static inline var E450:Int = 1806;
  public static inline var E451:Int = 1906;
  public static inline var E452:Int = 2006;
  public static inline var E453:Int = 2106;
  public static inline var E454:Int = 2206;
  public static inline var E455:Int = 2306;
  public static inline var E456:Int = 1607;
  public static inline var E457:Int = 1707;
  public static inline var E458:Int = 1807;
  public static inline var E459:Int = 1907;
  public static inline var E460:Int = 2007;
  public static inline var E461:Int = 2107;
  public static inline var E462:Int = 2207;
  public static inline var E463:Int = 2307;
  public static inline var E464:Int = 1608;
  public static inline var E465:Int = 1708;
  public static inline var E466:Int = 1808;
  public static inline var E467:Int = 1908;
  public static inline var E468:Int = 2008;
  public static inline var E469:Int = 2108;
  public static inline var E470:Int = 2208;
  public static inline var E471:Int = 2308;
  public static inline var E472:Int = 1609;
  public static inline var E473:Int = 1709;
  public static inline var E474:Int = 1809;
  public static inline var E475:Int = 1909;
  public static inline var E476:Int = 2009;
  public static inline var E477:Int = 2109;
  public static inline var E478:Int = 2209;
  public static inline var E479:Int = 2309;
  public static inline var E480:Int = 1610;
  public static inline var E481:Int = 1710;
  public static inline var E482:Int = 1810;
  public static inline var E483:Int = 1910;
  public static inline var E484:Int = 2010;
  public static inline var E485:Int = 2110;
  public static inline var E486:Int = 2210;
  public static inline var E487:Int = 2310;
  public static inline var E488:Int = 1611;
  public static inline var E489:Int = 1711;
  public static inline var E490:Int = 1811;
  public static inline var E491:Int = 1911;
  public static inline var E492:Int = 2011;
  public static inline var E493:Int = 2111;
  public static inline var E494:Int = 2211;
  public static inline var E495:Int = 2311;

  public static inline var TE00:Int = 1612;
  public static inline var TE01:Int = 1712;
  public static inline var TE02:Int = 1812;
  public static inline var TE03:Int = 1912;
  public static inline var TE04:Int = 2012;
  public static inline var TE05:Int = 2112;
  public static inline var TE06:Int = 2212;
  public static inline var TE07:Int = 2312;
  public static inline var TE08:Int = 1613;
  public static inline var TE09:Int = 1713;
  public static inline var TE10:Int = 1813;
  public static inline var TE11:Int = 1913;
  public static inline var TE12:Int = 2013;
  public static inline var TE13:Int = 2113;
  public static inline var TE14:Int = 2213;
  public static inline var TE15:Int = 2313;
  public static inline var TE16:Int = 1614;  
  public static inline var TE17:Int = 1714;
  public static inline var TE18:Int = 1814;
  public static inline var TE19:Int = 1914;
  public static inline var TE20:Int = 2014;
  public static inline var TE21:Int = 2114;
  public static inline var TE22:Int = 2214;
  public static inline var TE23:Int = 2314;

//Town Hall
  public static inline var TNHL:Int = 302;
  
  public static inline var EXIT:Int = 402;
  public static inline var EXRI:Int = 502;
  public static inline var EXUP:Int = 602;
  public static inline var EXLE:Int = 702;

//Terrian
  public static inline var GRAS:Int = 300;
  public static inline var GGRA:Int = 000;
  public static inline var MONT:Int = 002;
  public static inline var STRM:Int = 004;
  public static inline var BRDG:Int = 006;
  public static inline var BRKN:Int = 005;
  public static inline var SAND:Int = 009;

//Lake
 public static inline var LK01:Int = 606;
 public static inline var LK02:Int = 706;
 public static inline var LK03:Int = 806;
 public static inline var LK04:Int = 607;
 public static inline var LK05:Int = 707;
 public static inline var LK06:Int = 807;
 public static inline var LK07:Int = 608;
 public static inline var LK08:Int = 708;
 public static inline var LK09:Int = 808;

  public static inline var TILE:Int = 103;
  public static inline var KTIL:Int = 202;
  public static inline var YTIL:Int = 106;
  public static inline var BFLR:Int = 107;
  public static inline var RTIL:Int = 108;
  public static inline var OFLR:Int = 109;
  public static inline var PTIL:Int = 110;
  public static inline var GFLR:Int = 111;
//Roads
//Regular
  public static inline var ROAD:Int = 700;
//up
  public static inline var ROUP:Int = 701;
//Corners
  public static inline var RURC:Int = 702;
  public static inline var RLRC:Int = 703;
  public static inline var RLLC:Int = 704;
  public static inline var RULC:Int = 705;

//1 openings
  public static inline var RD1O:Int = 602;
  public static inline var RL1O:Int = 603;
  public static inline var RU1O:Int = 604;
  public static inline var RR1O:Int = 605;

//4-way
  public static inline var R4WY:Int = 506;	

//Fence
 public static inline var FEUP:Int = 502;
 public static inline var FERT:Int = 503;
 public static inline var FEDN:Int = 504;
 public static inline var FELT:Int = 505;
 
}

