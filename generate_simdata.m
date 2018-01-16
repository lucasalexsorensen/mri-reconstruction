function sim_image = generate_simdata(K, texFiles)
if K < 1 || K > 256
   error('Error: Given image size exceeds bounds (1-256) in generate_simdata');
end

if nargin >= 2
    if ischar(texFiles)
        tex_mode = 1;
    end
else
    tex_mode = 0;
end

sim_temp = zeros(K,K);

% cirkel placerings logik
c_center = [floor(K/5 + K/5*rand), floor(K/5 + K/5*rand)];
c_minimum = min([K-c_center(1), K-c_center(2), c_center(1), c_center(2)]);
radius = c_minimum * (0.5 + 0.5 * rand);

% trekant placerings logik
t_start = [floor(K/3 + K/3*rand), floor(K/3 + K/3*rand)];
t_minimum = min(K-t_start(1), K-t_start(2));
t_len = round(t_minimum * (0.5 + 0.5 * rand));

% rektangel
r_start = [floor(K/5 + K/3*rand), floor(K/5 + K/3*rand)];
r_minimum = min(K-r_start(1), K-r_start(2));
r_len = round(r_minimum * (0.5 + 0.5 * rand));

% trekant
if tex_mode; t_tex = im2double(imread(strcat(texFiles, 'tex1.png'))); end
t = tril(0.5*ones(t_len, t_len),-1);
%t = repmat(t,1,1,3);
[h, w, d] = size(t);
for i=1:h
   for j=1:w
       if t(i,j) > 0 && tex_mode == 1
           t(i,j) = t_tex(i,j);
       end
       sim_temp(i + t_start(1), j + t_start(2)) = sim_temp(i + t_start(1), j + t_start(2)) + t(i,j);
   end
end

% cirkel
if tex_mode; c_tex = im2double(imread(strcat(texFiles, 'tex2.png'))); end
[x,y] = meshgrid(1:K, 1:K);
isinside = (x - c_center(1)).^2 + (y - c_center(2)).^2 <= radius^2;
isinside = 0.5*isinside;

if tex_mode == 1
    for i=1:K
       for j=1:K
           if isinside(i,j) > 0
             isinside(i,j) = c_tex(i,j);
           end
       end
    end
end

sim_temp = sim_temp + isinside;

% rektangel
if tex_mode; rekt_tex = im2double(imread(strcat(texFiles, 'tex3.png'))); end
rekt = 0.5*ones(r_len, r_len);
rekt = repmat(rekt,1,1,3);
[rh, rw, rd] = size(rekt);
for i = 1:rh
   for j=1:rw
       if rekt(i,j) > 0 && tex_mode == 1
          rekt(i,j) = rekt_tex(i,j); 
       end
       sim_temp(i + r_start(1), j + r_start(2)) = sim_temp(i + r_start(1), j + r_start(2)) + rekt(i,j);
   end
end

%sim_temp(x > 1.0) = 1.0;

sim_image = sim_temp;
