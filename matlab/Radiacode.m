classdef Radiacode
    %RADIACODE An interface to a Radiacode device.
    %   Unfortunately, there is no protocol documentation (see
    %   https://github.com/cdump/radiacode/issues/4#issuecomment-1003606860),
    %   so this is just translating from the code in that repo.
    
    properties
        % TODO
    end

    properties (Access = private)
        rc_conn
    end

    properties (Constant)
        BAUD_RATE = 9600;
    end

    methods (Access = private)
        function send_msg(obj, msg)
            % Prepare to send.
            flush(obj.rc_conn);
            writeLine(obj.rc_conn, 1, 'uint8');
            
            % Send da msg.
            write(obj.rc_conn, uint8(hex2dec(msg)), 'uint8');
        end
    end
    
    methods
        function obj = Radiacode(port)
            %RADIACODE Setup a connection to an RC device.
            %   TODO
            obj.rc_conn = serialport(port, obj.BAUD_RATE);
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

