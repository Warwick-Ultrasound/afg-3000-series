function tek_afg_set_f(freq)
    % sets the frequency of the function generator, leaving all other
    % parameters unchanged.

    afg = visadev(list.ResourceName);
    writeline(afg, sprintf('SOUR1:FREQ:FIXed %dHz', freq));
end