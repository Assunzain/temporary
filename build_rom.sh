# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Project-Xtended/manifest.git -b xt -g default,-mips,-darwin,-notdefault
git clone https://github.com/Assunzain/local_manifest.git --depth 1 -b ProjectX .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 -j1 --fail-fast
 
# build rom
source build/envsetup.sh
lunch xtended_X01AD-userdebug
export BUILD_USERNAME=Assunzain
export BUILD_HOSTNAME=Assunzain
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Jakarta #put before last build command
make xtended


# 25
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
