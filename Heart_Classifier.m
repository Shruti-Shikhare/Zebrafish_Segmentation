figure(1);

scatter3(fishstats.X, fishstats.Y, fishstats.Z, 'filled');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;
%% to relabel misclassifications

figure(3);
hold on;
scatter3(T.X(T.Class == 'Ventricle'), T.Y(T.Class == 'Ventricle'), T.Z(T.Class == 'Ventricle'), 'filled','b');
scatter3(T.X(T.Class == 'AVC'), T.Y(T.Class == 'AVC'), T.Z(T.Class == 'AVC'), 'filled','g');
scatter3(T.X(T.Class == 'Atrium'), T.Y(T.Class == 'Atrium'), T.Z(T.Class == 'Atrium'), 'filled','r');
xlabel('X', 'FontSize', 20); ylabel('Y', 'FontSize', 20); zlabel('Z', 'FontSize', 20);
grid on;

%% antoine's GT plotted

figure(4);
hold on;
scatter3(Atrium.CentroidX, Atrium.CentroidY, Atrium.CentroidZ, 'filled','r');
scatter3(AVC.CentroidX, AVC.CentroidY, AVC.CentroidZ, 'filled','g');
scatter3(Ventricle.CentroidX,Ventricle.CentroidY, Ventricle.CentroidZ, 'filled','b');
xlabel('X'); ylabel('Y'); zlabel('Z'); title('WT GT');
grid on;


%% brush the avc and export 
labels = struct();
labels.avc = AVC1;
labels.atrium = Atrium1;
labels.ventricle = Ventricle1;
%% plot
figure(2);
hold on;
scatter3(labels.atrium(:,1), labels.atrium(:,2), labels.atrium(:,3), 'filled', 'r');
scatter3(labels.avc(:,1), labels.avc(:,2), labels.avc(:,3), 'filled','b');
scatter3(labels.ventricle(:,1), labels.ventricle(:,2), labels.ventricle(:,3), 'filled', 'g');
xlabel('X'); ylabel('Y'); zlabel('Z');
grid on;

%% save in excel
all_X = [labels.atrium(:,1); labels.avc(:,1); labels.ventricle(:,1)]; 
all_Y = [labels.atrium(:,2); labels.avc(:,2); labels.ventricle(:,2)];
all_Z = [labels.atrium(:,3); labels.avc(:,3); labels.ventricle(:,3)];

v = {'Atrium', 'AVC', 'Ventricle'};

all_labels = [];
all_labels = repelem(v,[length(labels.atrium(:,1)) length(labels.avc(:,1)) length(labels.ventricle(:,1)) ])';

X = [all_X , all_Y , all_Z];

table = array2table(X);

table.Properties.VariableNames{1} = 'X';
table.Properties.VariableNames{2} = 'Y';
table.Properties.VariableNames{3} = 'Z';
table.FourthColumn = all_labels;
table.Properties.VariableNames{4} = 'Class';

writetable(table, 'classified_wt_e3_edit_2.xlsx');

