PROJECT_NAME=demo-vue3

scripts=$(ls vue-demo-scripts)

for script in $scripts
do
    echo "\nEXECUTING $script..."
    ./vue-demo-scripts/$script
    echo "Done\n"
done

code .

cd $PROJECT_NAME
npm run dev
