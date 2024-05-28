rm -rf .repo/local_manifests/ &&
repo init -u https://github.com/NusantaraProject-ROM/android_manifest -b 10 
git clone https://github.com/Kneba/local_manifests --depth 1 -b nad .repo/local_manifests && 
/opt/crave/resync.sh &&
. build/envsetup.sh &&
lunch nad_X00T-userdebug && make target-files-package otatools

croot
./build/make/tools/releasetools/sign_target_files_apks -o -d vendor/lineage-priv/keys \
$OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip \
signed-target_files.zip

./build/make/tools/releasetools/ota_from_target_files -k vendor/lineage-priv/keys/releasekey \
--block --backup=true \
signed-target_files.zip \
signed-ota_update.zip
