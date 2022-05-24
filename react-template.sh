if [$#]
then
    mkdir $1
    cd $1
fi


npm init -y
npm install webpack webpack-cli \
 style-loader css-loader html-webpack-plugin \
 react react-dom babel-loader @babel/core \
 @babel/cli @babel/preset-env @babel/preset-react --save-dev

mkdir src
mkdir docs

echo 'node_modules' > .gitignore

echo .babelrc
{   "presets": ["@babel/env", "@babel/preset-react"]    }


tee -a webpack.config.js <<EOF
const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
    mode: 'development',
    entry: {
        index: './src/index.js',
    },
    plugins: [
        new HtmlWebpackPlugin({
            inject: false,
                'meta': {
                    'charset': "utf-8",
                    'viewport': 'width=device-width, initial-scale=1, shrink-to-fit=no'
                },
                title: 'index template',
                template: 'src/index.html',
        }),
    ],
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'docs'),
        clean: true,
    },
    module:{
        rules: [
            {
                test: /\.css$/i,
                use: ['style-loader', 'css-loader'],
            },
            {
                test: /\.(png|svg|jpg|jpeg|gif)$/i,
                type: 'asset/resource',
            },
            {
                test: /\.(js|jsx)$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader",
                    options: {
                        presets: ['@babel/preset-env']
                    }
                }
            },
        ],
    },
};
EOF

cd src

echo "" > style.css

tee -a index.html <<EOF
<!DOCTYPE html>
<html>
    <head>
        <%= htmlWebpackPlugin.tags.headTags %>
        <title><%= htmlWebpackPlugin.options.title %></title>
    </head>
    <body>
        <div id="root"></div>
    </body>
</html>
EOF

tee -a index.js <<EOF
import './style.css';
import React from 'react';
import ReactDOM from 'react-dom/client';


function ReactButton(props){
    function handleClick(){
        console.log("you clicked the react button")
    }
    return(
        <button onClick={handleClick}>{props.text}</button>
    )
}

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<ReactButton text='React'/>);
EOF
