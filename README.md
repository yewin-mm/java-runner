# java-runner
<!-- PROJECT SHIELDS -->

<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/yewin-mm/java-runner.svg?style=for-the-badge
[contributors-url]: https://github.com/yewin-mm/java-runner/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/yewin-mm/java-runner.svg?style=for-the-badge
[forks-url]: https://github.com/yewin-mm/java-runner/network/members
[stars-shield]: https://img.shields.io/github/stars/yewin-mm/java-runner.svg?style=for-the-badge
[stars-url]: https://github.com/yewin-mm/java-runner/stargazers
[issues-shield]: https://img.shields.io/github/issues/yewin-mm/java-runner.svg?style=for-the-badge
[issues-url]: https://github.com/yewin-mm/java-runner/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/ye-win-1a33a292/

<h1 align="center">
  Overview
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/view.png" /><br/>
</h1>


# java-runner
* This is the sample shell script to run `Java Archive` known as `JAR`.
* Even those you can run Java Application with many ways like run with Tomcat or Jboss or dockerized or etc., sometimes, you may need to run your Jar file with sample command like `java -jar app.jar`.
* So, this script is for that case. 
* You can use this script in any Linux Os and Mac OS.
* You can even run multiple `JAR` files by using this script and so, this script file can handle for many Java Applications with necessary action like `running`, `restarting`, `stopping`.
* You can see below [Instruction](#instruction) section as for command sample to use this shell script.

<!-- TABLE OF CONTENTS -->
## Table of Contents
- [About The Project](#about-the-project)
    - [Built With](#built-with)
- [Getting Started](#getting-started)
    - [Before you begin](#before-you-begin)
    - [Clone Project](#clone-project)
    - [Prerequisites](#prerequisites)
    - [Instruction](#instruction)
      -  [Start services](#start)
      -  [View services](#view)
      -  [Restart services](#restart)
      -  [Stop services](#stop)
- [Contact Me](#contact)
- [Contributing](#Contributing)


<a name="about-the-project"></a>
## ⚡️About The Project
This script is to run `JAR` files. <br>
You can use this script to run your applications in server.<br>
You can even run multiple `JAR` files by using this script and so, this script file can handle for many Java Applications with necessary action like `running`, `restarting`, `stopping`.

<a name="built-with"></a>
### 🪓 Built With
This project is built with
* Bash (You can use this script in any `Linux Os`)

<a name="getting-started"></a>
## 🔥 Getting Started
You can use this script above bash version 3, you can check your bash version in your terminal by typing `bash --version`. <br>
You can see below [Instruction](#instruction) section as for command sample to use this shell script.
Your OS have to be Linux based OS.

<a name="before-you-begin"></a>
### 🔔 Before you begin
You need JAR file to test this script and make sure your JAR file is able to run with `java -jar {jar name}`.


<a name="clone-project"></a>
### 🥡 Clone Project
* Clone the repo
   ```sh
   git clone https://github.com/yewin-mm/java-runner.git
   ```
<a name="prerequisites"></a>
### 🔑 Prerequisites
No need to add any special prerequisites. Just clone with above git clone command and your OS have to be Linux OS or Mac Os.


<a name="instruction"></a>
### 📝 Instruction
You need JAR file and that jar file is able to run (executable) with `java -jar {jar name}`.
So, Please make sure your jar file is able to run first.

<a name="start"></a>
#### Start Services
* You can start (run) your applications by using this script.
* Go to this java runner script file folder with `terminal`.
* If your user have root permission, Type
  ```sh
    sh java_runner.sh start
  ```
* If your user have not root permission, Type
  ```sh
    sudo sh java_runner.sh start
  ```
* There, you can see this script will request the service name which you want to `run`.
* In there, You can type `any name` you want and please note that `avoid special characters` in service name as my script will accept only for alphanumeric only.
* After that, the script will request your `JAR` file name.
* Add your JAR file name in there.
* Please note that if your JAR file is `not in the same directory` with this script, you need to type JAR file name which `including the valid path`. (eg. /home/app/employeeService.jar).
* After that you can see the message like service is `successfully started`, and you can call your application as it's alive after starting the service.
* Please note that, my script `won't generate log file` to see your application logs.
* So, if you want to see your application logs, you need to generate logs file by using logging tools like log4j, etc.
<h1 align="center">
  Start Sample 1
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/serviceAStart.png" /><br/>
</h1>

<h1 align="center">
  Start Sample 2
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/serviceBStart.png" /><br/>
</h1>

<h1 align="center">
  Start Sample 3
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/studentServiceStart.png" /><br/>
</h1>


<a name="view"></a>
#### View Services
* You can see your running applications if you run your applications by using this script.
* Go to this java runner script file folder with `terminal`.
* If your user have root permission, Type
  ```sh
    sh java_runner.sh view
  ```
* If your user have not root permission, Type
  ```sh
    sudo sh java_runner.sh view
  ```

* After that you can see your running applications by list, and you can also see the total number of running services too.
<h1 align="center">
  View Sample
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/view.png" /><br/>
</h1>


<a name="restart"></a>
#### Restart Services
* You can restart your applications if you run your applications by using this script.
* Go to this java runner script file folder with `terminal`.
* If your user have root permission, Type
  ```sh
    sh java_runner.sh restart
  ```
* If your user have not root permission, Type
  ```sh
    sudo sh java_runner.sh restart
  ```
  
* You can see the running services list and total count.
* This script will request you to type the number from running services list which you want to `restart`.
* Please note that you need to type `only the number` of your services as this script will accept number only.
* After you type the number, the script will restart your application.
<h1 align="center">
  Restart Sample
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/restart.png" /><br/>
</h1>

* After that you can check your application by typing `sh java_runner.sh view`.
<h1 align="center">
  Check after restart
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/viewAfterRestart.png" /><br/>
</h1>

* There you can see your restarted application is alive, and you can call your application to check your application is alive or not.

<a name="stop"></a>
#### Stop Services
* You can stop your applications if you start your applications by using this script.
* Go to this java runner script file folder with `terminal`.
* If your user have root permission, Type
  ```sh
    sh java_runner.sh stop
  ```
* If your user have not root permission, Type
  ```sh
    sudo sh java_runner.sh stop
  ```

* You can see the running services list and total count.
* This script will request you to type the number from running services list which you want to `stop`.
* Please note that you need to `type only the number` of your services as this script will accept number only.
* After you type the number, the script will stop your application.
<h1 align="center">
  Stop Sample
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/stop.png" /><br/>
</h1>

* After that you can check your running application by typing `sh java_runner.sh view`.

<h1 align="center">
  Check after stop
  <img src="https://github.com/yewin-mm/java-runner/blob/master/github/template/images/overview/viewAfterStop.png" /><br/>
</h1>

* There you can see your stopped application is not listed in running services list, and it's stopped.
* You can call your application to check your application is still alive or not.


***Have Fun and Enjoy in Learning Code***


<a name="contact"></a>
## ✉️ Contact
Name - Ye Win <br> LinkedIn profile -  [Ye Win's LinkedIn](https://www.linkedin.com/in/ye-win-1a33a292/)  <br> Email Address - yewin.mmr@gmail.com

Project Link: [Java Runner](https://github.com/yewin-mm/java-runner)


<a name="contributing"></a>
## ⭐ Contributing
Contributions are what make the open source community such an amazing place to be learnt, inspire, and create. Any contributions you make are **greatly appreciated**.
<br>If you want to contribute....
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/yourname`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeatures'`)
4. Push to the Branch (`git push -u origin feature/yourname`)
5. Open a Pull Request
