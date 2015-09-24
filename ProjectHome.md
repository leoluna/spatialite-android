# Spatialite for Android #
Sqlite extension for the Android platform.
## Getting started ##

NOTE: Currently, only builds using Linux (Ubuntu). To build on Mac OSX or Cygwin see [Issue5](https://code.google.com/p/spatialite-android/issues/detail?id=5).<br>

NOTE: There was a bug in PROJ.4 concerning android that was fixed after 4.8.0 release:  <a href='http://trac.osgeo.org/proj/changeset/2305'>http://trac.osgeo.org/proj/changeset/2305</a>.  I recommend you get the latest from PROJ SCM for now.<br>

Start by cloning the git repository<br>
<pre><code>git clone https://code.google.com/p/spatialite-android/ <br>
</code></pre>

In the JNI directory download, unpack, and configure GEOS and PROJ.4<br>
<pre><code>cd spatialite-android/spatialite-android-library/jni/<br>
wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz <br>
wget http://download.osgeo.org/geos/geos-3.3.6.tar.bz2 <br>
wget http://www.sqlite.org/2013/sqlite-amalgamation-3071602.zip<br>
wget http://www.gaia-gis.it/gaia-sins/libspatialite-sources/libspatialite-4.0.0.tar.gz <br>
tar -xvzf proj-4.8.0.tar.gz <br>
tar -xvjf geos-3.3.6.tar.bz2 <br>
unzip sqlite-amalgamation-3071602.zip <br>
tar -xvzf libspatialite-4.0.0.tar.gz <br>
cd proj-4.8.0/ <br>
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-eabi <br>
cd .. <br>
cd geos-3.3.6 <br>
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-eabi <br>
cd .. <br>
cd libspatialite-4.0.0/ <br>
./configure --build=x86_64-pc-linux-gnu --host=arm-linux-eabi <br>
cd .. <br>
</code></pre>
Build the native library<br>
<pre><code>$ /usr/local/android-ndk-r8b/ndk-build -j10<br>
</code></pre>
Run the app on emulator or device. First, copy the database to the desired location. Then navigate to "run tests".  When the "Press to Start" button is pressed the following should appear in the log<br>
<pre><code>05-25 09:49:38.863: VERBOSE/com.spatialite.TestActivity(5869): Columns: [Distance(PointFromText('point(-77.35368 39.04106)', 4326), PointFromText('point(-77.35581 39.01725)', 4326))]<br>
05-25 09:49:38.873: VERBOSE/com.spatialite.TestActivity(5869): Row: [0.0239050831414628]<br>
05-25 09:49:38.873: VERBOSE/com.spatialite.TestActivity(5869): Columns: [Name, Peoples, AsText(Geometry), GeometryType(Geometry), NumPoints(Geometry), SRID(Geometry), IsValid(Geometry)]<br>
05-25 09:49:38.873: VERBOSE/com.spatialite.TestActivity(5869): Row: [Genova, 610307, POINT(492370.69 4918665.57), POINT, null, 32632, 1]<br>
05-25 09:49:39.033: VERBOSE/com.spatialite.TestActivity(5869): Row: [Roma, 2546804, POINT(788703.57 4645636.3), POINT, null, 32632, 1]<br>
05-25 09:49:39.033: VERBOSE/com.spatialite.TestActivity(5869): Row: [Palermo, 686722, POINT(880179.17 4227024.08), POINT, null, 32632, 1]<br>
05-25 09:49:39.033: VERBOSE/com.spatialite.TestActivity(5869): Row: [Firenze, 356118, POINT(681514.97 4848768.02), POINT, null, 32632, 1]<br>
05-25 09:49:39.033: VERBOSE/com.spatialite.TestActivity(5869): Row: [Milano, 1256211, POINT(514820.49 5034534.56), POINT, null, 32632, 1]<br>
05-25 09:49:39.033: VERBOSE/com.spatialite.TestActivity(5869): Row: [Torino, 865263, POINT(395553.63 4991768.9), POINT, null, 32632, 1]<br>
05-25 09:49:39.043: VERBOSE/com.spatialite.TestActivity(5869): Row: [Napoli, 1004500, POINT(942636.1 4535272.55), POINT, null, 32632, 1]<br>
05-25 09:49:39.043: VERBOSE/com.spatialite.TestActivity(5869): Row: [Bologna, 371217, POINT(686263.23 4929405.15), POINT, null, 32632, 1]<br>
05-25 09:49:39.053: VERBOSE/com.spatialite.TestActivity(5869): Columns: [Distance( Transform(MakePoint(4.430174797, 51.01047063, 4326), 32631), Transform(MakePoint(4.43001276, 51.01041585, 4326),32631))]<br>
05-25 09:49:39.053: VERBOSE/com.spatialite.TestActivity(5869): Row: [12.8984912853814]<br>
</code></pre>

<h2>License</h2>
SpatiaLite-Android is licensed under the <a href='http://www.mozilla.org/MPL/boilerplate-1.1/mpl-tri-license-html'>MPL tri-license</a> terms; you are free to<br>
choose the best-fit license between:<br>
<br>
the MPL 1.1<br>
the GPL v2.0 or any subsequent version<br>
the LGPL v2.1 or any subsequent version<br>

<h2>Special Thanks</h2>

Thank you to everyone who contributed to the following thread: <a href='http://stackoverflow.com/questions/5145388/android-ndk-build-of-spatialite/'>http://stackoverflow.com/questions/5145388/android-ndk-build-of-spatialite/</a><br>
Mark Renouf - <a href='https://github.com/mrenouf/android-spatialite'>https://github.com/mrenouf/android-spatialite</a><br>
mateuszzz88 - R-Tree test cases<br>
Sebastian Krysmansk - Multiple fixes<br>