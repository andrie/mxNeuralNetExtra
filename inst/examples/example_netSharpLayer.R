layer_input(c(13, 13))
layer_input(c(3, 7, 7), "pixels")

layer_conv(NULL, c(2, 2), 
           inputshape = c(13, 13), 
           name = "conv1", 
           inputname = "pixels"
)
layer_conv(NULL, 
           c(2, 2), 
           inputshape = c(13, 13), 
           name = "conv1", 
           inputname = "pixels", 
           stride = c(2, 2)
)
layer_conv(NULL, 
           c(1, 2, 2), 
           inputshape = c(3, 13, 13), 
           name = "conv1", 
           inputname = "pixels", 
           stride = c(1, 2, 2)
)

layer_full(NULL, 100, name = "h3", inputname = "conv")
layer_output(NULL, 6, name = "class", inputname = "h3")


require(magrittr)

layer_input(c(3, 7, 7), name = "pixels") %>% attr("name")
layer_input(c(3, 7, 7), name = "pixels") %>% as.character()


layer_input(c(3, 50, 50), name = "pixels")

layer_input(c(3, 50, 50), name = "pixels") %>% 
  layer_conv(
    kernelshape = c(1, 5, 5),
    name = "conv1", 
    stride = c(1, 2, 3)
  )



#  ------------------------------------------------------------------------

# input pixels [3, 50, 50];
# hidden conv1 [48, 24, 24] rlinear from pixels convolve {
#   InputShape  = [3, 50, 50];
#   KernelShape = [3,  5,  5];
#   Stride      = [1,  2,  2];
#   LowerPad    = [0, 1, 1];
#   Sharing     = [T, T, T];
#   MapCount    = 48;
# }
# 
# hidden rnorm1 [48, 11, 11] from conv1 response norm {
#   InputShape  = [48, 24, 24];
#   KernelShape = [1,   4,  4];
#   Stride      = [1,   2,  2];
#   LowerPad    = [0, 0, 0];
#   Alpha       = 0.0001;
#   Beta        = 0.75;
# }
# 
# hidden pool1 [48, 9, 9] from rnorm1 max pool {
#   InputShape  = [48, 11, 11];
#   KernelShape = [1, 3, 3];
#   Stride      = [1, 1, 1];
# }
# 
# hidden hid1 [256] rlinear from pool1 all;
# hidden hid2 [256] rlinear from hid1 all;
# output Class [6] from hid2 all;

layer_input(c(3, 50, 50), name = "pixels") %>% 
  layer_conv(
    kernelshape = c(3, 5, 5), 
    name = "conv1", 
    stride = c(1, 2, 2),
    mapcount = 48
  )


layer_input(c(3, 50, 50), name = "pixels") %>% 
  layer_conv(
    kernelshape = c(3, 5, 5), 
    name = "conv1", 
    stride = c(1, 2, 2),
    mapcount = 48
  ) %>% 
  layer_conv(
    kernelshape = c(1, 4, 4), 
    stride = c(1, 2, 2),
    name = "conv2"
  ) %>% 
  layer_full(nodes = 100, name = "hid1") %>% 
  layer_full(nodes = 30, name = "hid2") %>% 
  layer_output(nodes = 6, name = "class")



