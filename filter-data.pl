#!/usr/bin/perl 
use CGI::Carp qw(fatalsToBrowser);

##################################
# Created By Ali Khan
# ali.ak.khan@oracle.com
# Property of Oracle
##################################

### File Names ###
my $new_file = 'new_file.csv';
my $merge_file = 'temp_file';

### User Input Data ###
my $user_level1;
my $user_level2;
my $user_level3;
my $user_level4;
my $user_level5;
my $user_level6;

### System Input Data ###
my $level1;
my $level2;
my $level3;
my $level4;
my $level5;
my $level6;

### Important Variables ###
my @full_data;
my @new_data;
my $val;
my $num = 0;
my $total_num = 0;

### Sub Routines ###
&collect_user_data();
&create_merge_file();
&read_merge_file();
&analyse_data();
&save_new_file();
&remove_merge_file();

print"Task Complete!\n";
print"Scanned Entries: $total_num.\n";
print"Match Entries: $num.\n";

if($num>0){print"File Created: $new_file\n";}
exit;

sub collect_user_data
{
    ### Collect User Input Data ###
    print "Please enter filter values:\n";
    print "Leave fields blank if not applicable:\n";
    
    print "Column Entry 1: ";
    $user_level1 = <STDIN>;
    chomp $user_level1;
    
    print "Column Entry 2: ";
    $user_level2 = <STDIN>;
    chomp $user_level2;

    print "Column Entry 3: ";
    $user_level3 = <STDIN>;
    chomp $user_level3;

    print "Column Entry 4: ";
    $user_level4 = <STDIN>;
    chomp $user_level4;

    print "Column Entry 5: ";
    $user_level5 = <STDIN>;
    chomp $user_level5; 
    
    print "Column Entry 6: ";
    $user_level6 = <STDIN>;
    chomp $user_level6;  

    if(($user_level1 eq '') || ($user_level1 eq ' '))
    {
        undef $user_level1;
    }
    if(($user_level2 eq '') || ($user_level2 eq ' '))
    {
        undef $user_level2;
    }
    if(($user_level3 eq '') || ($user_level3 eq ' '))
    {
        undef $user_level3;
    }
    if(($user_level4 eq '') || ($user_level4 eq ' '))
    {
        undef $user_level4;
    }        
    if(($user_level5 eq '') || ($user_level5 eq ' '))
    {
        undef $user_level5;
    }
    if(($user_level6 eq '') || ($user_level6 eq ' '))
    {
        undef $user_level6;
    }    
    
    #Zero Variables is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {        
        print"Nothing Is Defined.\n";
        print"Processed Stopped.\n";
        exit;
    }  

}

sub create_merge_file
{
    print"Data Crunching...\n";
    print"Processing Files...\n";
    
    #Delete Old Merge File If Exists
    if (-e $merge_file){ unlink($merge_file); }
    if (-e $new_file){ unlink($new_file); }
    
    #Create New Merge File
    system('cat *.csv > temp_file;');
    system('perl -Mopen=OUT,:crlf -pi.bak -e0 temp_file;');
}

sub read_merge_file
{
    ### Opening Merge File ###
    open FILEHANDLE, "$merge_file" or die "Cannot open file: $!";
		@full_data = <FILEHANDLE>;
    close(FILEHANDLE);
    
return();
}

sub analyse_data
{

    print"Analysing Data...\n";
    foreach $val(@full_data)
    {
        $val =~ s/^\s*//;
        chomp($val);

        #Set field values
        my @values = split /,/, $val;
        ($level1, $level2, $level3, $level4, $level5, $level6 ) = @values[0..5];

        $total_num++;
        &filter_data($val);
    }
}

sub filter_data
{
    
    my $value = shift;

#####################################################################################################################    
    #One Varibale Combination
#####################################################################################################################

    #Only level1 is defined 
    if((defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {

        if(($level1 eq $user_level1))
        {
            push(@new_data,$value);                
            $num++;
        }
        else
        {
            next;
        }
    }
    #Only level2 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)) && (!defined($user_level6)))
    {
    
        if(($level2 eq $user_level2))
        {   
            push(@new_data,$value);
            $num++;
        }
        else
        {            
            next;
        }
    }
    #Only level3 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {
    
        if(($level3 eq $user_level3))
        {   
            push(@new_data,$value);
            $num++;
        }
        else
        {            
            next;
        }
    }   
    #Only level4 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {
    
        if(($level4 eq $user_level4))
        {   
            push(@new_data,$value);
            $num++;
        }
        else
        {            
            next;
        }
    } 
    
    #Only level5 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    {
    
        if(($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }

    #Only level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    {

        if(($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }

#####################################################################################################################    
    #Two Varibale Combination
#####################################################################################################################    
    
    #level1 & level2 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level1 eq $user_level1) && ($level2 eq $user_level2))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }

    #level1 & level3 is defined 
    if((defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level1 eq $user_level1) && ($level3 eq $user_level3))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level1 & level4 is defined 
    if((defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level1 eq $user_level1) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level1 & level5 is defined 
    if((defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level1 eq $user_level1) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level1 & level6 is defined 
    if((defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    {   
        if(($level1 eq $user_level1) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }   
    
    #Two Varibale Combination
    #level2 & level3 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level2 eq $user_level2) && ($level3 eq $user_level3))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }

    #level2 & level4 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level2 eq $user_level2) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level2 & level5 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
        
        if(($level2 eq $user_level2) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level2 & level6 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
        
        if(($level2 eq $user_level2) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }   
    
    #Two Varibale Combination
    #level3 & level4 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {   
        if(($level3 eq $user_level3) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }

    #level3 & level5 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
        
        if(($level3 eq $user_level3) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level3 & level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
        
        if(($level3 eq $user_level3) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }   
    
    #Two Varibale Combination
    #level4 & level5 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
        
        if(($level4 eq $user_level4) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level4 & level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
        
        if(($level4 eq $user_level4) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }    
    #level5 & level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (defined($user_level6)))
    {         
        if(($level5 eq $user_level5) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    
    
    
#####################################################################################################################    
    #Three Varibale Combination
##################################################################################################################### 

    #level1, level2, level3 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level1, level2, level4 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }    
    #level1, level2, level5 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
    
    #level1, level2, level6 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }     
    #level2, level3, level4 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }     
    #level2, level3, level5 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }  

    #level2, level3, level6 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }
    #level3, level5, level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level3 eq $user_level3) && ($level5 eq $user_level5) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }   
    #level4, level5, level6 is defined 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level4 eq $user_level4) && ($level5 eq $user_level5) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }    

#####################################################################################################################    
    #Four Varibale Combination
#####################################################################################################################     
    #level1, level2, level3 level4 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }    
    #level1, level2, level3, level5 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
    #level1, level2, level3, level6 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (!defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }      
    
    #level2, level3, level4, level5 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
 
     #level2, level3, level4, level6 is defined 
    if((!defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
    

#####################################################################################################################    
    #Five Varibale Combination
#####################################################################################################################    
    #level1, level2, level2, level3, level4, level5 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (defined($user_level5)) && (!defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4) && ($level5 eq $user_level5))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
    #level1, level2, level2, level3, level4, level6 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (!defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    }   
    
#####################################################################################################################   
    #Full Varibale Combination
#####################################################################################################################    
    #level1, level2, level2, level3, level4, level5, level6 is defined 
    if((defined($user_level1)) && (defined($user_level2)) && (defined($user_level3)) && (defined($user_level4)) && (defined($user_level5)) && (defined($user_level6)))
    { 
    
        if(($level1 eq $user_level1) && ($level2 eq $user_level2) && ($level3 eq $user_level3) && ($level4 eq $user_level4) && ($level5 eq $user_level5) && ($level6 eq $user_level6))
        {
            push(@new_data,$value);
            $num++;
        }
        else
        {
            next;
        }
    } 
   
 #####################################################################################################################    
    #Zero Varibale Combination 
    if((!defined($user_level1)) && (!defined($user_level2)) && (!defined($user_level3)) && (!defined($user_level4)) && (!defined($user_level5)) && (!defined($user_level6)))
    {        
        print"Nothing is defined.\n";
        print"Processed stopped.\n";
        exit;
    }   
##################################################################################################################### 

return();
}

sub save_new_file
{   
    my $headers = $full_data[0];
    my $array_value= scalar(@new_data);

    if($array_value>0)
    {
        open FILEHANDLE, "> $new_file" or die "Cannot save file: $!";
            print FILEHANDLE "$headers\n";
            print FILEHANDLE "@new_data";
        close (FILEHANDLE);
    }
    else
    {
        print"Zero Match.\n";
        &remove_merge_file;
        exit;
    }
    
return();
}

sub remove_merge_file
{
    if (-e $merge_file){ unlink($merge_file); }
}
