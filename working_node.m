function [status, timer,flag] = working_node(pre_status_matrix, pre_next_status_timer,frame_size,first_frame_flag)
    %%pre_status_matrix : Ma trận chứa trạng thái trước đó của mỗi node
    %%pre_next_status_timer : Ma trận chứa bộ đếm th�?i gian cho trạng thái tiếp theo của mỗi node.
    %%frame_size : Ma trận chứa kích thước của các khung cho mỗi node.
    %%first_frame_flag : Flag cho biết đây có phải là khung đầu tiên hay k

    len=size(pre_status_matrix,1); %%số node
    status=zeros(len,1);
    timer=zeros(len,1);
    flag=first_frame_flag;
    
    for i=1:len
        if(pre_status_matrix(i)==4 && pre_next_status_timer(i)==1) %SIFS end, sending ACK;
            status(i)=5;
            timer(i)=3;
            
        end
        
        
        if(pre_status_matrix(i)==3 && pre_next_status_timer(i)>1) %reiceiving data;
            status(i)=3;
            timer(i)= pre_next_status_timer(i)-1;
            
        end
        
        
        if(pre_status_matrix(i)==5 && pre_next_status_timer(i)>1) %sending ACK;
            status(i)=5;
            timer(i)= pre_next_status_timer(i)-1;
            
        end
        
        if(pre_status_matrix(i)==2 && pre_next_status_timer(i)==1) %DIFS end start sending data;
            status(i)=3;
            timer(i) = frame_size(i);
            flag(i)=1;
        end
        
    end
    
    

end