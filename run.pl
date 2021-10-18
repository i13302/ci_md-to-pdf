#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

use Getopt::Long 'GetOptions';
use File::Basename 'basename';

sub ret_chomp
{
	my $var=shift;
	chomp($var);
	
	return $var
}

sub ret_ext_change
{
	my ($dstfile,$toext)=@_;
	$dstfile=~s/^(.*)\..*$/$1/;
	return $dstfile.'.'.$toext;
}

sub trim_workdir_css_files
{
	my ($work_dir,$ref_css_path)=@_;
	foreach(@$ref_css_path){
		$_=~s/^$work_dir\///;
	}
}

sub docker_cmd_mdtohtml
{
	my ($work_dir,$md_dir,$html_dir,$mdtohtml,$pwd,$md_name,$html_name,$ref_css_path)=@_;
	
	my @cmd=();
	$cmd[0]='docker run --rm --volume "'.$pwd.'/'.$work_dir.':/data" '.$mdtohtml.' -f markdown --self-contained '.$md_dir.'/'.$md_name;
	
	$cmd[1]='';
	foreach (@$ref_css_path){
		$cmd[1].='-c '.$_.' ';
	}
	
	$cmd[2]='-o '.$html_dir.'/'.$html_name;
	
	return join(' ',@cmd);
}


sub main
{
	my $work_dir='work';
	my $md_dir  ='markdown';
	my $html_dir='html';
	my $css_dir ='css';
	my $pdf_dir ='pdf';
	my $mdtohtml ='pandoc/latex';
	my $htmltopdf='i13302/printout';
	my $pwd      =&ret_chomp(`pwd`);

	GetOptions(
		'work=s'     =>\$work_dir,
		'markdown=s' =>\$md_dir,
		'html=s'     =>\$html_dir,
		'css=s'      =>\$css_dir,
		'pdf=s'      =>\$pdf_dir,
		'mdtohtml=s' =>\$mdtohtml ,
		'htmltopdf=s'=>\$htmltopdf,
		'pwd=s'      =>\$pwd
	);


	# print Dumper $htmltopdf,$pwd;

	my @md_path=glob $work_dir.'/'.$md_dir.'/*';
	my @css_path=glob $work_dir.'/'.$css_dir.'/*';
	
	trim_workdir_css_files($work_dir,\@css_path);

	# print @md_files;
	foreach(@md_path){
		my $md_name=&basename($_);
		my $html_name=&ret_ext_change($md_name,'html');
		
		system(&docker_cmd_mdtohtml($work_dir,$md_dir,$html_dir,$mdtohtml,$pwd,$md_name,$html_name,\@css_path));;
		print "\n";
	}

}

&main;
