[root@test-02 swapAlert]# pwd
/root/naveen/swapAlert
[root@test-02 swapAlert]# cat swapAlertCheck.sh
#!/bin/bash
logSwapDir=$PWD/log
if [ -d $logSwapDir ]
then
        echo ""
else
        mkdir -p $logSwapDir
fi
logSwap=$logSwapDir/swap%-`date +%F`.log
swapPercent=$(free -t | awk 'NR == 4 {printf("%d"), $3/$2*100}')
#swapPercent=$(free -t | grep Swap | awk '{print "Current Swap Utilization is : " $3/$2*100}')
swapLimit=10
if [ "$swapPercent" -gt "$swapLimit" ]
then
        echo $swapPercent >> $logSwap
                if [ -f $logSwap ]
                then
                        if [ -s $logSwap ]
                        then
                                #send email with attachment
                                echo "Sending email as "
                                echo "Swap Alert $swapPercent"
                        else
                                echo "Swap is under threshold"
                        fi
                else
                        echo "File not exist"
        fi
        else
                echo " Swap is under threshold"
fi


[root@test-02 swapAlert]# ll
total 12
drwx------ 2 root root 4096 May 24 11:00 log
-rw------- 1 root root  677 May 24 11:16 swapAlertCheck.sh
-rw------- 1 root root  452 May 24 11:25 test.sh
[root@test-02 swapAlert]#
	 
	
	-----------
[root@test-02 swapAlert]# cat test.sh
#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Basic Information"
echo "</title></head><body>"
echo "<h1>General system information for host $(hostname -s)</h1>"
echo ""
echo "<h1>Memory Info</h1>"
echo "<pre> `free -m` </pre>"
echo "<h1>Disk Info:</h1>"
echo "<pre> `df -h` </pre>"
echo "<h1>Logged in user</h1>"
echo "<pre> `whoami` </pre>"
echo "<center>Information generated on `date`</center>"
echo "</body></html>"

[root@test-02 swapAlert]#
	-----------------
	
	(
echo "From: email@removed "
echo "To: email@removed "
echo "MIME-Version: 1.0"
echo "Content-Type: multipart/alternative; " 
echo ' boundary="PAA08673.1018277622/server.xyz.com"' 
echo "Subject: Test HTML e-mail." 
echo "" 
echo "This is a MIME-encapsulated message" 
echo "" 
echo "--PAA08673.1018277622/server.xyz.com" 
echo "Content-Type: text/html" 
echo "" 
echo "<html> 
<head>
<title>HTML E-mail</title>
</head>
<body>
<a href='http://www.google.com'>Click Here</a>
</body>
</html>"
echo "--PAA08673.1018277622/server.xyz.com"
) | sendmail -t
