CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar' #set the envirornment for junit

rm -rf student-submission #delete the exisiting submission
git clone $1 student-submission #change the directory name to student-submission and clone
echo 'Finished cloning'


set -e
if [[ -f $(find student-submission -name "ListExamples.java") ]]; then
  echo "File Exist!!!"
else
  echo "File Does Not Exist!!!"
  exit 1
fi
path=`find student-submission -name "ListExamples.java"`
cp -n "$path" ./student-submission/

cd ./student-submission
set +e
cp ../TestListExamples.java ./
cp -r ../lib ./
javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
if [ $? -ne 0 ]  #if the exit code is not 0, the file fails to compile
then
  echo "The File Does Not Compile!!!"
   exit 1
fi

echo "The File Compiles!!!"
# redirect the output of junit test to new file
java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > result.txt

if grep  "OK" result.txt ; then
    echo "Score: Pass"
else
    echo "Score: Fail"
fi

exit 0