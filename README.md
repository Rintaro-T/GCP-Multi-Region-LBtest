# GCP-Multi-Region-LBtest
GCP Multi Region Load Balancer Test

GCP上のTokyoとLasVegasの二つのリージョンにそれぞれインスタンスグループを立ち上げ，これらを一つのバックエンドサービスとし，ロードバランサのテストをする．
インスタンスグループはオートスケーラにより自動増減．それぞれのリージョンでは複数のゾーンにまたがってインスタンスが立ち上がるようになっている．

## How to Use / 使い方
#### Need Packages / 必要なパッケージ
- Packer
- Ansible
- Terraform
- Google Cloud SDK
- git

#### Google Cloud SDK Login

```
$ gcloud auth login
$ gcloud auth application-default login
```

#### Create Project, setting default project and Enable API

*You have to change YOUR\_PROJECT\_ID to your project name.*

```
$ gcloud projects create YOUR_PROJECT_ID --name Multi-Region-LBtest
$ gcloud config set project YOUR_PROJECT_ID
```

You have to set the payment of this project on web browser. / ここでウェブブラウザよりこのプロジェクトの支払い設定を行う．

```
$ gcloud services enable compute.googleapis.com
```

#### Downloads

```
$ mkdir ~/GCP
$ cd ~/GCP
$ git clone https://github.com/Rintaro-T/GCP-Multi-Region-LBtest
```

#### Create Image with Packer

*You have to change YOUR_PROJECT_ID to your project name.*


Tokyo Image
```
$ cd ~/GCP/GCP-Multi-Region-LBtest/packer/tokyo
$ sed s/multi-region-lbtest-20210917/YOUR_PROJECT_ID/g -i ./main.json
$ packer build main.json
```

LasVegas Image
```
$ cd ~/GCP/GCP-Multi-Region-LBtest/packer/vegas
$ sed s/multi-region-lbtest-20210917/YOUR_PROJECT_ID/g -i ./main.json
$ packer build main.json
``` 

Check Images
```
$ gcloud compute images list|grep csnginx
csnginx-tokyo                                         multi-region-lbtest-20210917                                                READY
csnginx-vegas                                         multi-region-lbtest-20210917                                                READY
```

#### Create System with Terraform

*You have to change YOUR_PROJECT_ID to your project name.*

```
$ cd ~/GCP/GCP-Multi-Region-LBtest/terraform
$ sed s/multi-region-lbtest-20210917/YOUR_PROJECT_ID/g -i ./01-common.tf
$ terraform init
$ terraform plan
$ terraform apply
```
#### Management project in Terraform ( Optional )

*You have to change YOUR_PROJECT_ID to your project name.*
```
$ cd ~/GCP/GCP-Multi-Region-LBtest/terraform
$ sed s/multi-region-lbtest-20210917/YOUR_PROJECT_ID/g -i ./01-common.tf
$ sed 13,16s/^#//g -i ./01-common.tf
$ terraform import google_project.YOUR_PROJECT_ID YOUR_PROJECT_ID
```

#### Check the Service ( Optional )

Get IP addr of Front End of Load Balancer
```
$ gcloud compute addresses list|grep mrlb-address
```

Access the page
```
$ gcloud compute addresses list|grep mrlb-address|awk '{print $2}'|xargs curl|grep from
```

When you are in Japan,
```
   <h1>This is Google LB test page from Tokyo</h1>
```

When you are in LasVegas,
```
   <h1>This is Google LB test page from Vegas</h1>
```

#### Check the AutoScaler ( Optional )

Coming soon
