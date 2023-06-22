PROJECT_NAME=demo-vue3

scripts=$(ls vue-demo-scripts)

for script in $scripts
do
    ./vue-demo-scripts/$script
done

code .

cd $PROJECT_NAME
npm run dev
