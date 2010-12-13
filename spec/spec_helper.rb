require File.join(File.dirname(__FILE__), '..', 'dart.rb')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'fakeweb'

set :environment, :test

Rspec.configure do |config|
  config.mock_with :rspec
end

FakeWeb.register_uri(:get, "http://www.irishrail.ie/realtime/publicinfo.asp?strLocation=CNLLY", :body => '<?xml version="1.0"?><rss version="2.0"><channel><title>irishrail.ie: Dublin Connolly -Current time is: 00:05am</title><description>Estimated Time of Arrival:</description><link>http://www.irishrail.ie</link><item><title>Terminates at  Dublin Connolly</title><description>E702 - Origin : Howth - Destination : Dublin Connolly | -   Expected arrival at Dublin Connolly : 00:11 -   Terminates at  Dublin Connolly</description></item><item><title>Terminates at  Dublin Connolly</title><description>E701 - Origin : Bray - Destination : Dublin Connolly | -   Expected arrival at Dublin Connolly : 00:15 -   Terminates at  Dublin Connolly</description></item></channel></rss>')
FakeWeb.register_uri(:get, "http://www.irishrail.ie/your_journey/ajax/ajaxRefreshResults.asp?station=Seapoint", :body => "<table width='100%' border=0 bordercolor=green cellpadding=0 cellspacing=1><tr height=25 bgcolor=#e3e1fa><td colspan=6><table width=100% border=0 bordercolor=red cellpadding=0 cellspacing=1><tr><td align=right width='40%'><b>&nbsp;&nbsp;Departure Station&nbsp;&nbsp;&nbsp;</b></td><td width='33%'><input type=text id=txtRealtimeResultsStation name=txtRealtimeResultsStation value='Seapoint' autocomplete=off onkeyup=javascript:checkKeyPress(this.value,event) class=txtMiniJP onclick=javascript:this.value=''><a href='../home/maps/intercity_map.asp?field=realtimeResults&height=620&width=540' class=thickbox><input name=txtMaps id=txtMaps type=text onmouseover=document.getElementById('txtMaps').style.cursor='pointer' class=txtRTResultsMapsImg /></a></td><td valign=bottom><a href=javascript:ajaxRefreshResults()><img src='../images/Realtime/Refresh.gif' border=0 alt=Refresh></a></td></tr><tr><td></td><td valign=top><div id='realtimeResultsStationSuggest'></div></td></tr></table></td></tr><tr height=25 bgcolor=#0d174c><td colspan=6><table width=100% border=0 bordercolor=blue><tr><td><b class='title2'>Realtime Results for&nbsp;Seapoint - 12:27</b></td><td width=25px align=right><a href='../realtime/publicinfo.asp?strLocation=SEAPT'><img src='/images/rss_small.gif' alt='RSS feed for Seapoint' style='position:relative;top:-54px;padding-top:3px' /></a></td></tr></table></td></tr><tr height=25 bgcolor=#0d174c><td><b class=title2>&nbsp;Journey Northbound</b></td><td align=center><b class=title2><div id=ajaxContent runat=server style=''></div>Service</b></td><td align=center><b class=title2>Sch</b></td><td align=center><b class=title2>ETA</b></td><td  align=center><b class=title2>Due In</b></td><td><b class=title2>&nbsp;Latest Information</b></td><tr height=25 bgcolor=#e3e1fa><td>&nbsp;Bray&nbsp;to&nbsp;Malahide(<A HREF='#' onclick=javascript:viewtrain('E813;20xxNovxx2010;E813-12:10-BrayxxtoxxMalahide(0xxminsxxlate);images/ietops_northbound.gif',event)>E813</A>)</td><td align=center>DART</td><td align=center>12:33</td><td align=center><font color=BLACK>12:33</font></td><td align=center>6 Mins</td><td>&nbsp;Arrived Sandycove</td></tr><tr height=25 bgcolor=#FFFFFF><td>&nbsp;Bray&nbsp;to&nbsp;Howth(<A HREF='#' onclick=javascript:viewtrain('E915;20xxNovxx2010;E915-12:25-BrayxxtoxxHowth(1xxminsxxlate);images/ietops_northbound.gif',event)>E915</A>)</td><td align=center>DART</td><td align=center>12:48</td><td align=center><font color=BLACK>12:49</font></td><td align=center>22 Mins</td><td>&nbsp;Departed Bray</td></tr><tr height=25 bgcolor=#e3e1fa><td>&nbsp;Greystones&nbsp;to&nbsp;Howth(<A HREF='#' onclick=javascript:viewtrain('E947;20xxNovxx2010;E947-12:30-GreystonesxxtoxxHowth(0xxminsxxlate);images/ietops_northbound.gif',event)>E947</A>)</td><td align=center>DART</td><td align=center>13:03</td><td align=center><font color=BLACK>13:03</font></td><td align=center>36 Mins</td><td>&nbsp;&nbsp;</td></tr><tr height=25 bgcolor=#FFFFFF><td>&nbsp;Bray&nbsp;to&nbsp;Howth(<A HREF='#' onclick=javascript:viewtrain('E916;20xxNovxx2010;E916-12:55-BrayxxtoxxHowth(0xxminsxxlate);images/ietops_northbound.gif',event)>E916</A>)</td><td align=center>DART</td><td align=center>13:18</td><td align=center><font color=BLACK>13:18</font></td><td align=center>51 Mins</td><td>&nbsp;&nbsp;</td></tr><tr height=25 bgcolor=#0d174c><td><b class=title2>&nbsp;Journey Southbound</b></td><td align=center><b class=title2>Service</b></td><td align=center><b class=title2>Sch</b></td><td align=center><b class=title2>ETA</b></td><td  align=center><b class=title2>Due In</b></td><td><b class=title2>&nbsp;Latest Information</b></td></tr><tr height=25 bgcolor=#e3e1fa><td>&nbsp;Howth&nbsp;to&nbsp;Bray(<A HREF='#' onclick=javascript:viewtrain('E212;20xxNovxx2010;E212-11:45-HowthxxtoxxBray(3xxminsxxlate);images/ietops_southbound.gif',event)>E212</A>)</td><td align=center>DART</td><td align=center>12:29</td><td align=center><font color=BLACK>12:32</font></td><td align=center>5 Mins</td><td>&nbsp;Departed Sydney Parade</td></tr><tr height=25 bgcolor=#FFFFFF><td>&nbsp;Malahide&nbsp;to&nbsp;Greystones(<A HREF='#' onclick=javascript:viewtrain('E112;20xxNovxx2010;E112-12:00-MalahidexxtoxxGreystones(1xxminsxxlate);images/ietops_southbound.gif',event)>E112</A>)</td><td align=center>DART</td><td align=center>12:44</td><td align=center><font color=BLACK>12:45</font></td><td align=center>18 Mins</td><td>&nbsp;Departed Dublin Connolly</td></tr><tr height=25 bgcolor=#e3e1fa><td>&nbsp;Howth&nbsp;to&nbsp;Bray(<A HREF='#' onclick=javascript:viewtrain('E213;20xxNovxx2010;E213-12:15-HowthxxtoxxBray(0xxminsxxlate);images/ietops_southbound.gif',event)>E213</A>)</td><td align=center>DART</td><td align=center>12:59</td><td align=center><font color=BLACK>12:59</font></td><td align=center>32 Mins</td><td>&nbsp;Arrived Kilbarrack</td></tr><tr height=25 bgcolor=#FFFFFF><td>&nbsp;Malahide&nbsp;to&nbsp;Bray(<A HREF='#' onclick=javascript:viewtrain('E245;20xxNovxx2010;E245-12:30-MalahidexxtoxxBray(0xxminsxxlate);images/ietops_southbound.gif',event)>E245</A>)</td><td align=center>DART</td><td align=center>13:14</td><td align=center><font color=BLACK>13:14</font></td><td align=center>47 Mins</td><td>&nbsp;&nbsp;</td></tr></tr></table>")