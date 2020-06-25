#/bin/sh
# Bir xml dosyasında belli bir kritere uyan satirin bir altindaki satiri guncellemek icin bu script kullanilabilir.
# 
# 
# 
# Ornek olarak;
# TestDS'i undeploy etmek icin once TestDS'in gectigi satiri bulur.
# sonra bir alt satirdaki target tag'inden cluster ifadesini kaldirir.
# grep -n  '<name>TestDS</name>' /tmp/config.xml: icinde "<name>TestDS</name>" ifadesi gecen satırın satır numarasını ve ifadeyi bulur.
# ornek cikti: 429:    <name>TestDS</name>
# awk '{print $1}' : ciktinin "429:" kismini alir.
# sed 's/.$//' : iki nokta ust uste karakterini kirpar
# ornek cikti: 429
# target kismindan cluster'in silinmesi icin bir alttaki satir numarasina ulasmak icin 1 eklenir ve sed komutuyla cluster ifadesi silinir.


configXmlPath=/tmp/config.xml


# undeploy TestDS
lineNumber=$(grep -n  '<name>TestDS</name>' /tmp/config.xml | awk '{print $1}' | sed 's/.$//');
#echo $lineNumber; 
sum=$(($lineNumber + 1));
#echo $sum;
#sed -i '430s/<target>cluster<\/target>/<target><\/target>/' config.xml
sed -i ''${sum}'s/<target>cluster<\/target>/<target><\/target>/g' $configXmlPath;

# undeploy test-integration-mdbs.jar
lineNumber=$(grep -n  '<name>test-integration-mdbs.jar</name>' $configXmlPath | awk '{print $1}' | sed 's/.$//');
#echo $lineNumber; 
sum=$(($lineNumber + 1));
#echo $sum;
sed -i ''${sum}'s/<target>cluster<\/target>/<target><\/target>/g' $configXmlPath;


# undeploy test2-integration-mdbs.jar.jar
lineNumber=$(grep -n  '<name>test2-integration-mdbs.jar.jar</name>' $configXmlPath | awk '{print $1}' | sed 's/.$//');
#echo $lineNumber; 
sum=$(($lineNumber + 1));
#echo $sum;
sed -i ''${sum}'s/<target>cluster<\/target>/<target><\/target>/g' $configXmlPath;
