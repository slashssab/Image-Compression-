osa = rgb2ycbcr(imread('Tiger.jpg'));

X = fix(osa(:, :, 2) * 255);  Y = X;

H = size(X, 1); V = size(X, 2); b = 2^3; hb = b - 1;

 JPG_QT=[16  11  10  16   24   40   51   61;
12  12  14  19   26   58   60   55;
14  13  16  24   40   57   69   56;
14  17  22  29   51   87   80   62;
18  22  37  56   68   109  103   77;
24  35  55  64   81   104  113   92;
49  64  78  87  103  121  120  101;
72  92  95  98  112  100  103   99];

% JPEG quantization table 'ceil(log(q)/log(2))' assesses a number of lost bits

if b == 2^3

   q = floor(JPG_QT / 4); q(q == 0) = 1; Q = repmat(q, H/b, V/b);

else  

   Q = 2^-2; % Prunes n LSBs from each coefficient

end

%                            Encoder part

for i = 0:H/b - 1

   for j = 0:V/b - 1

        % bxb block partition for 2D DCT

        bH = (i*b:i*b + hb) + 1; bV = (j*b:j*b + hb) + 1;

        X(bH, bV) = dct2(X(bH, bV) - 128, [b b]);  

   end

end

         

 



X = fix(X./Q);                         

 

     

       

 


 


 

M = read('jpg.rle.light', -1, 2);

[M T] = huffcode(M + 1);

%[M1 T1] = huffcode(M(:, 1) + 1); [M2 T2] = huffcode(M(:, 2) + 1); M = M1 + M2;

 

unix('del jpg.rle.light');  write('jpg.rle.light', M);

disp(length(M)/8, 'Compressed RLE [bytes] = '); % disp(T);

 

%                            Decoder part

% "De-quantization"

X = X.*Q; 

for i = 0:H/b - 1

   for j = 0:V/b - 1

        % bxb block partition 2D inverse DCT

        bH = 1 + (i*b:i*b + hb); bV = 1 + (j*b:j*b + hb);

        X(bH, bV) = fix(idct2(X(bH, bV), [b b])) + 128;               

   end

end

 

imshow(mat2gray(X - Y)); imwrite(mat2gray(X), 'osa-Y.png');

disp(norm(X - Y)/255, 'Average Squared Error = ');

imshow(mat2gray(X));

%/// Actual JPEG blocky artifacts

%osa_art = rgb2ycbcr(imread('osa-art.png')); // Medium|Low quality (5|1)

%diff_art = osa(:, :, 2) - osa_art(:, :, 2);

%imshow(mat2gray(diff_art)); disp(norm(diff_art));

 