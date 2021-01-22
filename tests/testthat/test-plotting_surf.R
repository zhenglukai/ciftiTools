check_wb <- function() {
  wb_path <- try(
    get_wb_cmd_path(ciftiTools.getOption("wb_path"), verbose=FALSE),
    silent=TRUE
  )
  if ("try-error" %in% class(wb_path)) {
    skip("Connectome Workbench is not available.")
  }
}

test_that("plot_xifti_surface and related functions are working", {

  check_wb()


  fnames <- demo_files()
  for (cii_fname in fnames$cifti) {
    cii <- readcii(cii_fname)
    print(cii$cifti$intent)
    plot(cii); rgl::rgl.close()
    print("sequential")
    plot(cii, color_mode="sequential"); rgl::rgl.close()
    plot(cii, color_mode="sequential", zlim=c(2, 5)); rgl::rgl.close()
    plot(cii, color_mode="sequential", zlim=c(5, 2)); rgl::rgl.close()
    print("diverging")
    plot(cii, color_mode="diverging"); rgl::rgl.close()
    plot(cii, color_mode="diverging", zlim=c(2, 5)); rgl::rgl.close()
    plot(cii, color_mode="diverging", zlim=c(5, 2)); rgl::rgl.close()
    plot(cii, color_mode="diverging", zlim=c(2, 3, 5)); rgl::rgl.close()
    plot(cii, color_mode="diverging", zlim=c(5, 3, 2)); rgl::rgl.close()
    print("qualitative")
    cii$data$cortex_left[] <- round(cii$data$cortex_left)
    cii$data$cortex_right[] <- round(cii$data$cortex_right)
    plot(cii, color_mode="qualitative"); rgl::rgl.close()
    plot(cii, color_mode="qualitative", zlim=3); rgl::rgl.close()
    plot(cii, color_mode="qualitative", zlim=30); rgl::rgl.close()
  }

})