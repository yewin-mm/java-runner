#!/bin/bash

########################################################################################
###############    The script is to run java application as a service    ###############
###############           Created by Ye Win on 03/10/2021                ###############
########################################################################################
#####            Gmail        - yewin.mmr@gmail.com                                #####
#####            LinkedIn     - https://www.linkedin.com/in/ye-win-1a33a292/       #####
#####            Project Link - https://github.com/yewin-mm/java-runner            #####
########################################################################################

echo ""
echo "##################################################################################################################################"
echo ""
echo "****************************************************************************************"
echo "========    The script is to run java application as a service   ========"
echo "========             Created by Ye Win on 03/10/2021             ========"
echo "========================================================================="
echo "==== Gmail        - yewin.mmr@gmail.com                          ========"
echo "==== LinkedIn     - https://www.linkedin.com/in/ye-win-1a33a292/ ========"
echo "==== Project Link - https://github.com/yewin-mm/java-runner      ========"
echo "****************************************************************************************"
echo ""
echo "****************************************************************************************"
echo "***** Run command sample -> 'sh java_runner.sh' or 'sudo sh java_runner start' *****"
echo "***** Command type -> 'start', 'stop', 'restart', 'view'                       *****"
echo "***** command 'start' is to start the application                              *****"
echo "***** command 'stop' is to stop the application                                *****"
echo "***** command 'restart' is to restart the application                          *****"
echo "***** command 'view' is to view which applications is running now              *****"
echo "****************************************************************************************"
echo ""
echo "****************************************************************************************"

ACTION=$1
TEMP_PID_PATH=/tmp/java-service/pid/
TEMP_FILE_PATH=/tmp/java-service/file/

JAR_EXT=.jar

JAR_LOC=_File_Path


run(){
    jar_path=$1
    pid_path_store=$2
    jar_path_store=$3
    service_name=$4
    action=$5

    echo "--INFO-- Running process was started --INFO--"

    nohup java -jar $jar_path /tmp/java-service 2>> /dev/null >> /dev/null &
            echo $! > $pid_path_store

    echo $jar_path > $jar_path_store

    echo "--INFO-- Service: $service_name was successfully $action. --INFO--"
    echo "--INFO-- Please take care of your application port not to same with other running application. --INFO--"
    echo "--INFO-- You need to generate logs files to see your application logs in your application (use log4j or etc). --INFO--"
}

check_process(){
    jar=$1
    CHECK=$(pgrep -f $jar)
    echo "--INFO-- Checking jar file is running or not. --INFO--"

    if pgrep -f $jar > /dev/null
    then
        echo "--WARN-- $jar is already running. --WARN--"
        echo "--INFO-- Killing the existing process was started. --INFO--"
        kill $CHECK
    fi

    echo "--INFO-- Checking process was completed. --INFO--"
}

clear(){
    jar_path_store=$1
    pid_path_store=$2
    action=$3

    if [[ ! $action == "loop" ]]; then
        echo "--INFO-- Clearing process was started. --INFO--"
    fi
    

    if [ -f $jar_path_store ]; then
        rm $jar_path_store
    fi

    if [ -f $pid_path_store ]; then
        rm $pid_path_store
    fi


    if [[ ! $action == "loop" ]]; then
        echo "--INFO-- Clearing process was completed. --INFO--"
    fi
    
}

active_service(){
    array=("$@")
    j=1

    echo "Active service list:"

    for ((i=0; i<${#array[@]}; i++)); do

        CHECK_PROCESS=${array[$i]}

        PID_PATH=$TEMP_PID_PATH$CHECK_PROCESS
        FILE_PATH=$TEMP_FILE_PATH$CHECK_PROCESS$JAR_LOC

        PROCESS_ID=$(cat $PID_PATH);

        if ps -p $PROCESS_ID > /dev/null
        then
            dict[$j]=${array[$i]}

            echo "$j - ${array[$i]}"

            ((j=j+1))

        else
            # echo "--INFO-- Clear unactive service, Service Name: $CHECK_PROCESS. --INFO--"
            clear $FILE_PATH $PID_PATH "loop"
        fi

    done

    ((j=j-1))

    echo "Total number of active services: $j"

    echo ""
    echo "-----------------------------------------"

    echo $dict
}


start(){

    if [ ! -d "$TEMP_PID_PATH" ]; then
        `mkdir -p $TEMP_PID_PATH`;
    fi

    if [ ! -d "$TEMP_FILE_PATH" ]; then
        `mkdir -p $TEMP_FILE_PATH`;
    fi

    echo "!!!!! Pleaes type service name (your application) name which you want to start. eg. CalculatorService, StudentService, etc. !!!!!"
    read SERVICE_NAME

    # check for alpha numeric
    if [[ ! $SERVICE_NAME =~ ^[[:alnum:]]+$ ]];then
        echo "--ERROR-- Service: $SERVICE_NAME include special characters (eg. #-&*!^}@/, etc). --ERROR--"
        echo "--ERROR-- Service: $SERVICE_NAME cannot be start. --ERROR--"

    else

        length=${#SERVICE_NAME}
        if (( length < 50 ))
        then

            # SERVICE_NAME=${SERVICE_NAME//[[:blank:]]/}

            PID_PATH_STORE_NAME=$TEMP_PID_PATH$SERVICE_NAME

            JAR_PATH_STORE_NAME=$TEMP_FILE_PATH$SERVICE_NAME$JAR_LOC

            echo "--INFO-- Starting Service: $SERVICE_NAME ----INFO"
            echo ""

            echo "!!!!! Please type jar file name with extension (add path also if not in same directory. eg.app.jar or home/app.jar) !!!!!"
            read PATH_TO_JAR
            echo ""
            echo "Your jar file name: $PATH_TO_JAR"
            echo ""

            if [[ $PATH_TO_JAR =~ $JAR_EXT ]];
            then

                if [ -f $PATH_TO_JAR ]; then

                    if [ ! -f $PID_PATH_STORE_NAME ]; then

                        clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "start"

                        check_process $PATH_TO_JAR

                        run $PATH_TO_JAR $PID_PATH_STORE_NAME $JAR_PATH_STORE_NAME $SERVICE_NAME "started"

                    else
                        echo "--WARN-- Service: $SERVICE_NAME is already exist. --WARN--"
                        echo "--INFO-- Service killing process was started. --INFO--"

                        
                        PID=$(cat $PID_PATH_STORE_NAME);
                        if ps -p $PID > /dev/null
                        then
                            echo "--WARN-- Your process is alive with pid: $PID --WARN--"
                            echo "--INFO-- Killing process was started. --INFO--"
                            kill $PID


                            clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "start"

                            check_process $PATH_TO_JAR

                            echo "--INFO-- Restarting service. --INFO--"

                            run $PATH_TO_JAR $PID_PATH_STORE_NAME $JAR_PATH_STORE_NAME $SERVICE_NAME "started"
                
                        else

                            clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "start"

                            check_process $PATH_TO_JAR

                            echo "--INFO-- Restarting service. --INFO--"

                            run $PATH_TO_JAR $PID_PATH_STORE_NAME $JAR_PATH_STORE_NAME $SERVICE_NAME "started"

                        fi
                    fi


                else
                    echo "--ERROR-- Your JAR file is not valid. Please check file path and name. --ERROR--"
                    echo "--ERROR-- Service: $SERVICE_NAME cannot be start. --ERROR--"
                    
                fi

            else
                echo "--ERROR-- Type valid jar file name with extenstion. (eg.app.jar or home/app.jar) --ERROR--"
                echo "--ERROR-- Service: $SERVICE_NAME cannot be start. --ERROR--"
            fi
        
        else
            echo "--ERROR-- Service name length is more than 50 characters. --ERROR--"
            echo "--ERROR-- Service: $SERVICE_NAME cannot be start. --ERROR--"
        fi

    fi

    echo "****************************************************************************************"
    echo ""
    echo "##################################################################################################################################"
    echo ""
}


stop(){

    if [ ! -d "$TEMP_PID_PATH" ]; then
        `mkdir -p $TEMP_PID_PATH`;
    fi

    if [ ! -d "$TEMP_FILE_PATH" ]; then
        `mkdir -p $TEMP_FILE_PATH`;
    fi

    echo "--INFO-- Stopping Service --INFO--"
    echo ""

    arr=( $( ls $TEMP_PID_PATH ) )

    if (( ${#arr[@]} == 0 )); then
        echo "--INFO-- No active service was found. --INFO--"
    else

        active_service "${arr[@]}"

        check_data=${dict[1]}

        if [ ${check_data} ]
        then

            echo "!!!!! Type number from above list which you want to stop: "
            read number

            number=`echo $number | sed -e 's/^[[:space:]]*//'`

            if [[ $number =~ ^[0-9]+$ ]]; then

                SERVICE_NAME=${dict[$number]}

                echo "Service Name: $SERVICE_NAME, Service Number: $number"
                

                PID_PATH_STORE_NAME=$TEMP_PID_PATH$SERVICE_NAME

                JAR_PATH_STORE_NAME=$TEMP_FILE_PATH$SERVICE_NAME$JAR_LOC

                if [ -f $PID_PATH_STORE_NAME ]; then


                    PID=$(cat $PID_PATH_STORE_NAME);
                    if ps -p $PID > /dev/null
                    then
                        echo "--INFO-- Your process is alive with pid: $PID --INFO--"
                        echo "--INFO-- Killing process was started. --INFO--"
                        kill $PID

                        clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "stop"
            
                    else
                        echo "--INFO-- Your service process is stopped already. --INFO--"
                        clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "stop"

                    fi

                    echo "--INFO-- Service: $SERVICE_NAME was successfully stopped. --INFO--"

                else
                    echo "--ERROR-- Service: $SERVICE_NAME is not running. --ERROR--"
                    clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "stop"
                fi

            else
                echo "--ERROR-- Please type number only from above list to stop the application  --ERROR--"
                echo "--ERROR-- Service: $SERVICE_NAME can't be stop. --ERROR--"
            fi
        else
            echo "--INFO-- There is no active services. --INFO--"

        fi
    fi

    echo "****************************************************************************************"
    echo ""
    echo "##################################################################################################################################"
    echo ""
}


restart(){
    if [ ! -d "$TEMP_PID_PATH" ]; then
        `mkdir -p $TEMP_PID_PATH`;
    fi

    if [ ! -d "$TEMP_FILE_PATH" ]; then
        `mkdir -p $TEMP_FILE_PATH`;
    fi

    echo "--INFO-- Restarting Service --INFO--"
    echo ""

    arr=( $( ls $TEMP_PID_PATH ) )

    if (( ${#arr[@]} == 0 )); then
        echo "--INFO-- No active service was found. --INFO--"
    else

        active_service "${arr[@]}"

        check_data=${dict[1]}

        if [ ${check_data} ]
        then

            echo "!!!!! Type number from above list which you want to restart: "
            read number

            number=`echo $number | sed -e 's/^[[:space:]]*//'`

            if [[ $number =~ ^[0-9]+$ ]]; then
                SERVICE_NAME=${dict[$number]}
                echo ""
                echo "Service Name: $SERVICE_NAME, Service Number: $number"
                

                PID_PATH_STORE_NAME=$TEMP_PID_PATH$SERVICE_NAME
                JAR_PATH_STORE_NAME=$TEMP_FILE_PATH$SERVICE_NAME$JAR_LOC

                PID=$(cat $PID_PATH_STORE_NAME);
                JAR_FILE=$(cat $JAR_PATH_STORE_NAME);

                if ps -p $PID > /dev/null
                    then
                        echo "--INFO-- Service: $SERVICE_NAME is stopping with PID: $PID --INFO--";
                        echo "--INFO-- Killing process was started. --INFO--"
                        kill $PID

                        echo "--INFO-- Service: $SERVICE_NAME was stopped. --INFO--"

                        clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "restart"
            
                    else
                        echo "--WARN-- Your service process is stopped already. --WARN--"
                        clear $JAR_PATH_STORE_NAME $PID_PATH_STORE_NAME "restart"

                fi

                if [ -f $JAR_FILE ]; then
                    check_process $JAR_FILE

                    run $JAR_FILE $PID_PATH_STORE_NAME $JAR_PATH_STORE_NAME $SERVICE_NAME "restarted"
                else
                    echo "--ERROR-- Your JAR file is not exist in last location. Please check your JAR file is existed or not in: $JAR_FILE --ERROR--"
                    echo "--ERROR-- Could not restart the service: $SERVICE_NAME. --ERROR--"
            
                fi

                
            else
                echo "--ERROR-- Please type number only from above list to stop the application  --ERROR--"
                echo "--ERROR-- Could not restart the service: $SERVICE_NAME. --ERROR--"
            fi

        else
            echo "--INFO-- There is no active services. --INFO--"
        fi

    fi

    echo "****************************************************************************************"
    echo ""
    echo "##################################################################################################################################"
    echo ""
}


view(){
    if [ ! -d "$TEMP_PID_PATH" ]; then
        `mkdir -p $TEMP_PID_PATH`;
    fi
    
    if [ ! -d "$TEMP_FILE_PATH" ]; then
        `mkdir -p $TEMP_FILE_PATH`;
    fi

    echo "--INFO-- View Running Services --INFO--"
    echo ""

    arr=( $( ls $TEMP_PID_PATH ) )

    if (( ${#arr[@]} == 0 )); then
        echo "--INFO-- No active service was found. --INFO--"
    else

        active_service "${arr[@]}"

        check_data=${dict[1]}

        if [ ! ${check_data} ]
        then
            echo "--INFO-- There is no active services. --INFO--"
        fi
    fi

    echo "****************************************************************************************"
    echo ""
    echo "##################################################################################################################################"
    echo ""
}


case $ACTION in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        restart
    ;;
    view)
        view
    ;;
    *)
        echo "--ERROR-- Please type valid command. eg. sudo sh runner.sh start (command - start, stop, restart, view) --ERROR--"
        echo "****************************************************************************************"
        echo ""
        echo "##################################################################################################################################"
        echo ""
    ;;
esac

