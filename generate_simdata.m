% Parameters:
%  K - image length/width in the range 1-256 (Number)
%  texFiles - relative path to directory containing texture images (String)
% Output:
%  sim_image - K x K output image with three randomly rendered figures (Matrix[2d])
function sim_image = generate_simdata(K, texFiles)
% dimensionscheck
if K < 1 || K > 256
   error('Error: Given image size exceeds bounds (1-256) in generate_simdata');
end

% check inputparametre
if nargin >= 2
    if ischar(texFiles)
        tex_mode = 1;
    end
else
    tex_mode = 0;
end

% midletidig billedvariabel
sim_temp = zeros(K,K);

% cirkel placerings logik
c_center = [floor(K/5 + K/5*rand), floor(K/5 + K/5*rand)];
c_minimum = min([K-c_center(1), K-c_center(2), c_center(1), c_center(2)]);
radius = c_minimum * (0.5 + 0.5 * rand);

% trekant placerings logik
t_start = [floor(K/3 + K/3*rand), floor(K/3 + K/3*rand)];
t_minimum = min(K-t_start(1), K-t_start(2));
t_len = round(t_minimum * (0.5 + 0.5 * rand));

% rektangel placerings logik
r_start = [floor(K/5 + K/3*rand), floor(K/5 + K/3*rand)];
r_minimum = min(K-r_start(1), K-r_start(2));
r_len = round(r_minimum * (0.5 + 0.5 * rand));

% TREKANT
% hvis der skal læses texture, så hent pixeldata derfra
if tex_mode; t_tex = im2double(imread(strcat(texFiles, 'tex1.png'))); end
% tril-kommandoen fremstiller en nedre-trekants matrix som skal være vores trekant
%  bemærk, at pixelværdierne sættes til 0.5 (grå)
t = tril(0.5*ones(t_len, t_len),-1);

% nedenstående løkke sørger for at lægge trekantens pixels til det
%  midlertidige billede
[h, w, d] = size(t);
for i=1:h
   for j=1:w
       % hvis textures skal vises, så hent pixelværdien derfra
       if t(i,j) > 0 && tex_mode == 1
           t(i,j) = t_tex(i,j);
       end
       % addér pixelværdien det korrekte sted
       sim_temp(i + t_start(1), j + t_start(2)) = sim_temp(i + t_start(1), j + t_start(2)) + t(i,j);
   end
end

% CIRKEL
% hvis der skal læses texture, så hent pixeldata derfra
if tex_mode; c_tex = im2double(imread(strcat(texFiles, 'tex2.png'))); end

% der opstilles et koordinatsystem, og cirklens ligning benyttes
[x,y] = meshgrid(1:K, 1:K);
isinside = (x - c_center(1)).^2 + (y - c_center(2)).^2 <= radius^2;
isinside = 0.5*isinside; % laves til grå pixels (0.5 pixelværdi)

% hvis textures skal vises, så byt alle cirklens pixelværdier med texturens
%  pixelværdier
if tex_mode == 1
    for i=1:K
       for j=1:K
           if isinside(i,j) > 0
             isinside(i,j) = c_tex(i,j);
           end
       end
    end
end

% addér pixelværdier til det midlertidige billede
sim_temp = sim_temp + isinside;

% REKTANGEL
% hvis der skal læses texture, så hent pixeldata derfra
if tex_mode; rekt_tex = im2double(imread(strcat(texFiles, 'tex3.png'))); end
rekt = 0.5*ones(r_len, r_len);
rekt = repmat(rekt,1,1,3);
[rh, rw, rd] = size(rekt);

% nedenstående løkke sørger for at lægge rektanglens pixels til det
%  midlertidige billede
for i = 1:rh
   for j=1:rw
       % hvis textures skal vises, så hent pixelværdien derfra
       if rekt(i,j) > 0 && tex_mode == 1
          rekt(i,j) = rekt_tex(i,j); 
       end
       % addér pixelværdien det korrekte sted
       sim_temp(i + r_start(1), j + r_start(2)) = sim_temp(i + r_start(1), j + r_start(2)) + rekt(i,j);
   end
end

sim_image = sim_temp;
