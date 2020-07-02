#!/bin/bash
# 

export instanceName=jenkins
export appHome=/mw/jenkins
export JENKINS_HOME=${appHome}/home
export JENKINS_WAR=${appHome}/jenkins.war
export httpPort=8080
export httpsPort=8081
export httpsKeyStore=${appHome}/cert/wildcard.jks
export httpsKeyStorePassword=<password>
export extractedFilesFolder=${appHome}/temp
export trustStore=${appHome}/cert/wildcard_trust.jks
export trustStorePassword=<password>
export JAVA_HOME=/mw/tools/java/jdk1.8.0_161/
export JAVA_OPTS="-Dfile.encoding=utf-8 \
  -Dhttps.protocols=TLSv1.2 \
  -Dhttp.nonProxyHosts=localhost\|127.0.0.1\|*.local\|*.test.com.tr \
  -Dhttp.proxyHost=proxy.test.com.tr \
  -Dhttps.proxyHost=proxy.test.com.tr \
  -Dhttp.proxyPort=8080 \
  -Dhttps.proxyPort=8080 \
  -Djava.security.egd=file:/dev/./urandom \
  -Djavax.net.ssl.trustStore=${trustStore} \
  -Djavax.net.ssl.trustStorePassword=${trustStorePassword} \
  -Djavax.net.ssl.keyStore=${httpsKeyStore} \
  -Djavax.net.ssl.keyStorePassword=${httpsKeyStorePassword} \
  -Dorg.eclipse.jetty.server.Request.maxFormContentSize=900000 \
  -Duser.timezone=GMT+3 \
  -XX:-BytecodeVerificationLocal \
  -XX:-BytecodeVerificationRemote \
  -XX:-UseLargePagesIndividualAllocation \
  -XX:+DisableExplicitGC \
  -XX:+ExplicitGCInvokesConcurrent \
  -XX:+HeapDumpOnOutOfMemoryError \
  -XX:+ParallelRefProcEnabled \
  -XX:+PrintAdaptiveSizePolicy \
  -XX:+PrintGC \
  -XX:+PrintGCDateStamps \
  -XX:+PrintGCCause \
  -XX:+PrintGCDetails \
  -XX:+PrintHeapAtGC \
  -XX:+PrintReferenceGC \
  -XX:+PrintTenuringDistribution \
  -XX:+ReduceSignalUsage \
  -XX:+UnlockDiagnosticVMOptions \
  -XX:+UnlockExperimentalVMOptions \
  -XX:+UseCompressedClassPointers \
  -XX:+UseCompressedOops \
  -XX:+UseG1GC \
  -XX:+UseGCLogFileRotation \
  -XX:+UseStringDeduplication \
  -XX:G1NewSizePercent=20 \
  -XX:G1SummarizeRSetStatsPeriod=1 \
  -XX:GCLogFileSize=20m \
  -XX:NumberOfGCLogFiles=5 \
  -XX:HeapDumpPath=${appHome}/logs/${instanceName}.hprof \
  -XX:ErrorFile=${appHome}/logs/${instanceName}.hs_err_pid.log \
  -Xloggc:${appHome}/logs/${instanceName}.gc.log"

export JENKINS_ARGS="--httpPort=${httpPort} \
  --httpsPort=${httpsPort} \
  --httpsKeyStore=${httpsKeyStore} \
  --httpsKeyStorePassword=${httpsKeyStorePassword} \
  --prefix=/jenkins \
  --extractedFilesFolder=${extractedFilesFolder}"
  
# --prefix=/jenkins apache httpd'de istekler bu sekilde redirect edildigi icin kullanildi.
# Apache httpd'de / -> / olursa --prefix kullanilmamali.
# 80/443 iptables ile yonlendirilme yapilacaksa da iptables kullanilmamali.
# https://wiki.jenkins.io/pages/viewpage.action?pageId=135468777


# ------------------------------------------------------------------------------
# Instance'in prosess numarasini dondurur.
# ------------------------------------------------------------------------------
getProcessId () {

  process_id=$(ps -eF | grep instanceName=${instanceName} | grep -vw grep | awk '{print $2}')
  echo "$process_id"

}

archiveLogs () {
  
  if [[ $processId = "" ]]; then  
    current_date=`date +"%Y%m%d"`
    current_time=`date +"%H%M"`
    log_dir_of_today=${appHome}/archive/logs/${current_date}
    log_dir_of_now=${log_dir_of_today}/${current_time}
    mkdir -m 755 -p ${log_dir_of_today}
    mkdir -m 755 -p ${log_dir_of_now}

    mv ${appHome}/logs/* ${log_dir_of_now} 2>/dev/null
  fi

}

start () {
  processId=$(getProcessId)
  if [[ $processId = "" ]]; then
    archiveLogs
    echo "Jenkins is starting..."
      nohup ${JAVA_HOME}/bin/java -DinstanceName=${instanceName} \
      ${JAVA_OPTS} \
      -jar ${JENKINS_WAR} \
      ${JENKINS_ARGS} \
        >> ${appHome}/logs/${instanceName}.out 2>&1 &
    echo "Jenkins is started."
  else
    echo "Jenkins process just running. No need to start a new Jenkins."
  fi
}

tailf () {
  tail -1000f ${appHome}/logs/jenkins.out
}

stop () {
  processId=$(getProcessId)
  if [[ $processId != "" ]]; then
    echo "ProcessId=${processId} process olduruluyor.."
    kill -9 ${processId} && echo "ProcessId=${processId} process olduruldu"
  else
    echo "There is no Jenkins process, no need to kill."
  fi
}

restart () {
  stop
  start
}

# https://bit.ly/2DhOGsX
# Get all function lists in this script and assign to an array funcs
funcs=(`declare -F -p | cut -d " " -f 3`);


printUsage () {
  echo "Usageable fonctions are '${funcs[@]}' "
}

if [[ "${1}" = "" ]] ; then
  echo "Command must be entered ."
  printUsage
  exit 1
elif [[ "${funcs[@]}" =~ "${1}" ]] ; then
  ${1}
else
  echo "Unknown command has been called: ${1} ."
  printUsage
  exit 1
fi

