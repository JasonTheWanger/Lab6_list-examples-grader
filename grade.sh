CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f "student-submission/ListExamples.java" ]]
then 
    echo "submission file has found"
else
    echo "submission file not found"
    exit
fi

cp *.java grading-area
cp -r student-submission/ListExamples.java grading-area
cp -r lib grading-area

cd grading-area

javac -cp $CPATH:. *.java

if [[ $? -eq "0" ]]
then 
    echo "Compilation success"
else 
    echo "Compilation Failed"
fi

java -cp $CPATH:. org.junit.runner.JUnitCore TestListExamples > test-result

if [[ $? -ne "0" ]]
then
    totalTests=$(grep -r "Tests run: " test-result | cut -f3 -d' ' | cut -f1 -d',')
    totalFailures=$(grep -r "Tests run: " test-result | cut -f6 -d' ')
    successes=$((totalTests - totalFailures))
    echo "Your score is $successes / $totalTests"
else 
    totalPassTests=$(grep -r "OK" test-result | cut -f2 -d' ' | cut -f2 -d'(')
    echo "Your score is $totalPassTests / $totalPassTests"
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests