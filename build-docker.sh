sudo apt install -y qemu-user-static

sudo docker run -d --name builder -v $(pwd):/mnt/workdir -w /mnt/workdir ubuntu:noble tail -f /dev/null
sudo docker exec -i builder /bin/bash -c "sh -e scripts/install_deps.sh"
sudo docker exec -i builder /bin/bash -c "sh -e scripts/build_hyp_aboot.sh"
sudo docker exec -i builder /bin/bash -c "sh -e scripts/extract_fw.sh"
sudo docker exec -i builder /bin/bash -c "sh -e scripts/debootstrap.sh"
sudo docker exec -i builder /bin/bash -c "sh -e scripts/build_gt.sh"
sudo docker exec -i builder /bin/bash -c "sh -e scripts/build_images.sh"
echo "---- READY at files/* ----"
sudo docker kill builder
sudo docker rm builder
