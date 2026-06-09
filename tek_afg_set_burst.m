function tek_afg_set_burst(freq, amp, Ncycles)
    % sets the afg to a sinusiodal burst with specified frequency,
    % amplitude and number of cycles.

    % look for connected instruments
    list = visadevlist;
    if isempty(list)
        error("No AFG found.");
    end

    % configure the connection
%     instrreset;
    afg = visadev(list.ResourceName);

    % Reset the function generator to a known state
%     writeline(afg, '*RST');
%     writeline(afg, '*CLS;');

    % set to burst mode 
    writeline(afg, 'SOUR1:BURS:MODE TRIG');
    writeline(afg, 'SOURce1:BURSt:STATe ON');

    % set frequency
    writeline(afg, sprintf('SOUR1:FREQ:FIXed %dHz', freq));

    % set amplitude
    writeline(afg, sprintf('SOURce1:VOLTage:LEVel:IMMediate:AMPLitude %dVPP', amp));

    % set number of cycles
    writeline(afg, sprintf('SOURce1:BURSt:NCYCles %d', Ncycles));

    % Turn on Channel 1 output
    writeline(afg, ':OUTP1 ON');

    % Clean up - close the connection and clear the object
    clear afg;

   
end