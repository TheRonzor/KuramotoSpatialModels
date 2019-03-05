function SaveSettings(s, tStamp)
    %save(['../Output/Settings_' tStamp '.mat'], 's')
    writetable(struct2table(s), ['../Output/Settings_' tStamp '.txt'])
    disp('Saved settings')
end