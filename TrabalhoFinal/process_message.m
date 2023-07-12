function process_message(obj,event)
global Comando
   while obj.BytesAvailable 
       readval = fread(obj,1);
       fprintf('char: %c \n',readval);
       if readval == 'C'
           Comando="1";
       end
       if readval == 'B'
           Comando="2";
       end
       if readval == 'E'
           Comando="3";
       end
       if readval == 'D'
           Comando="4";
       end
       if readval == 'P'
           Comando="5";
       end
   end
end

