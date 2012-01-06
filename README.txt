This is a set of functions to (greatly, I hope) ease use of psychtoolbox (http://psychtoolbox.org/HomePage).

Warning: has only been tested has on Matlab 7.4 running on OS X Lion (10.7.2) but should be very portable.

# Installation: 
  1. Download latest version from,
   https://github.com/andsoandso/simplepsychtoolbox/tags

  2. Unzip the download into the desired installation directory and add that and all subdirectories to Matlab's path (i.e. use pathtool).

  3. A working installation of psychtoolbox is (obviously) needed too.

# Notes:
  - [11/16/2011] While feature complete for this inital posting, such as it is, substantial testing and debugging is still needed. Once that is done this file will be updated.

  - [11/21/2011] Functions have all received (at least) basic testing and seem to be working as intended.  For use information, see each functions own inline comments and the two experimental templates along, with their triallist creation mates (e.g. experimental_template_II.m along with create_trialist_II.m).

  - [1/2/2012] Functions that end in 'INC' are for use with the Siemens 3T at the Intermountain Neuroimaging Consortium (INC) facility located at the University of Colorado at Boulder.  Some exist for MRI interaction, others (for example, get_resp_INC) are workarounds for specfiic bugs or oddities in that system.


