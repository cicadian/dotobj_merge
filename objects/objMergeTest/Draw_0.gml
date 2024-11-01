//Turn on z-writing and z-testing so we're ready for 3D rendering
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);

//Counterclockwise faces are backfaces. We want to cull these so we're drawing less
gpu_set_cullmode(cull_counterclockwise);

//Texture repeating is required to render a lot of .obj files
//For now, all textures are externally imported sprites so they can handle texture
//repeats just fine, though for atlased textures this method may not work
gpu_set_tex_repeat(true);

//Turn on anisotropic filtering because why not, we're showing off
gpu_set_tex_mip_enable(mip_on);
gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_max_aniso(16);

//Set our view + projection matrices
var _old_world      = matrix_get(matrix_world); 
var _old_view       = matrix_get(matrix_view); 
var _old_projection = matrix_get(matrix_projection);

matrix_set(matrix_view, matrix_build_lookat(cam_x, cam_y, cam_z,
                                            cam_x+cam_dx, cam_y+cam_dy, cam_z+cam_dz,
                                            0, 1, 0));
matrix_set(matrix_projection, matrix_build_projection_perspective_fov(90, room_width/room_height, 1, 3000));

//Finally, draw the model
matrix_set(matrix_world, matrix_build(0,0,0, 0,-point_direction(0, 0, cam_x, cam_z) + 90,0, 50, 50, 50));
model_a.Submit();
model_b.Submit();
model_c.Submit();
matrix_set(matrix_world, matrix_build(-100,0,0, 0,0,0, 100, 100, 100));
model_a.Submit();
matrix_set(matrix_world, matrix_build(100,0,0, 0,0,0, 100, 100, 100));
model_b.Submit();
matrix_set(matrix_world, matrix_build(-100,-75,0, 0,0,0, 100, 100, 100));
model_ab.Submit();
matrix_set(matrix_world, matrix_build(100,-75,0, 0,0,0, 100, 100, 100));
model_ba.Submit();
matrix_set(matrix_world, matrix_build(0,-150,0, 0,0,0, 100, 100, 100));
model_abc.Submit();

//Reset draw state
matrix_set(matrix_world     , _old_world     );
matrix_set(matrix_view      , _old_view      );
matrix_set(matrix_projection, _old_projection);
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_cullmode(cull_noculling);
gpu_set_tex_repeat(false);
gpu_set_tex_mip_enable(mip_off);