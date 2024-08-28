function del_go_tools_folder() {
  echo "Removing old go tools if it exists"
  rm -rf $PWD/go
}
