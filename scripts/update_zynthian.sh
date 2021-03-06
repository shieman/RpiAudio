#!/bin/bash

if [ -f "./zynthian_envars.sh" ]; then
	source "./zynthian_envars.sh"
elif [ -z "$ZYNTHIAN_SYS_DIR" ]; then
	source "/zynthian/zynthian-sys/scripts/zynthian_envars.sh"
else
	source "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars.sh"
fi

echo "Updating zynthian-sys ..."
cd $ZYNTHIAN_SYS_DIR
cp -a scripts/zynthian_envars.sh /tmp
git checkout .
git pull
cp -a /tmp/zynthian_envars.sh ./scripts

cd ./scripts
./update_zynthian_sys.sh
./update_zynthian_recipes.sh

echo "Updating zyncoder ..."
cd $ZYNTHIAN_DIR/zyncoder
git checkout .
git pull
cd build
cmake ..
make

echo "Updating zynthian-ui ..."
cd $ZYNTHIAN_UI_DIR
git checkout .
git pull

echo "Updating zynthian-webconf ..."
cd $ZYNTHIAN_DIR/zynthian-webconf
git checkout .
git pull
