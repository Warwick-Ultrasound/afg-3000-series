function tek_afg_set_arb(t, V)
    % sets the afg to output an arbitrary waveform specified in t, V. the
    % address is the 'USB ID' found in th ultility menu of the instrument.
    % To use this fuction you must have tekVisa installed from the
    % tektronics website.

    % look for connected instruments
    list = visadevlist;
    if isempty(list)
        error("No AFG found.");
    end

    % configure the connection
    instrreset;
    afg = visadev(list.ResourceName);

    % Reset the function generator to a know state
    writeline(afg, '*RST');
    writeline(afg, '*CLS;');

    % normalise waveform
    Vnorm = V/max(V);

    % convert to DAC values
    Vint =  round((Vnorm + 1.0)*8191);

    % encode into binary waveform data
    binblock = zeros(2 * length(t), 1);
    binblock(2:2:end) = bitand(Vint, 255);
    binblock(1:2:end) = bitshift(Vint, -8);
    binblock = binblock';

    % Build binary block header
    bytes = num2str(length(binblock));
    header = ['#' num2str(length(bytes)) bytes];
    
    % Resets the contents of edit memory and define the length of signal
    writeline(afg, ['DATA:DEF EMEM, ' num2str(length(t)) ';']); %1001

    % Transfer the custom waveform from MATLAB to edit memory of instrument
    writebinblock(afg, [':TRACE EMEM, ' header binblock ';'], 'uint8');

    % Associate the waveform in edit memory to channel 1
    writeline(afg, 'SOUR1:FUNC EMEM');

    % Set the output frequency to 1 Hz. This is important since the custom
    % waveform's frequency is further upconverted to the value set below.
    writeline(afg, 'SOUR1:FREQ:FIXed 1Hz');

    % Turn on Channel 1 output
    writeline(afg, ':OUTP1 ON');

    % Clean up - close the connection and clear the object
    clear afg;
end