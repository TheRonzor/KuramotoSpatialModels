function SaveSettings(s, tStamp)
    % Inputs:
    %       s: a structure containing the simulation settings
    %       tStamp: a string used to name the file.
    %
    % NOTE: A directory called Output should exist one level up from where
    %       this script is saved, otherwise an error will be generated.
    writetable(struct2table(s), ['../Output/Settings_' tStamp '.txt'])
    disp('Saved settings')
end