var app = angular.module("FEFront", []);
app.directive('ngEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if(event.which === 13) {
                scope.$apply(function (){
                    scope.$eval(attrs.ngEnter);
                });

                event.preventDefault();
            }
        });
    };
});
app.directive('ngConfirmClick', function(){
	return {
		link: function (scope, element, attr) {
			var msg = attr.ngConfirmClick || "Are you sure?";
			var clickAction = attr.confirmedClick;
			element.bind('click',function (event) {
				if ( window.confirm(msg) ) {
					scope.$eval(clickAction)
				}
			});
		}
	};
})
app.filter('iif', function () {
	return function(input, trueValue, falseValue) {
		return input ? trueValue : falseValue;
	};
});
app.controller("DocumentsListController", function($scope, $http){
	$http.get('../documents/list.json').success(function(data) {
		console.log(data);
		$scope.documents = data;
	});
});
app.controller("InviteController", function($scope, $http){
	$scope.message = "";
	$scope.invite = function(){
		var emails = $scope.emails;
		$scope.emails = undefined;
		if($scope.validateEmails(emails))
		{
			console.log(emails);
			$http.get('../users/invite.json?t=participant&d=' + $scope.document_id + '&e=' + emails).success(function(data) {
				console.log(data);
			});
		}
	}
	$scope.validateEmails = function(emails){
		var valid_emails = true;
		if(emails != undefined)
		{
			emails = emails.replace(/ /g,'');
			emails_arr = emails.split(",");
			for(var index = 0; index < emails_arr.length; index++)
			{
				if($scope.validateEmail(emails_arr[index]) == false)
				{
					valid_emails = false;
					break;
				}
			}
		}
		else
			valid_emails = false;
		return valid_emails;
	}
	$scope.validateEmail = function(email) { 
		var re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
		return re.test(email);
	}
});
app.controller("NewUserInviteController", function($scope, $http){
	$scope.message = "";
	$scope.invite = function(){
		var emails = $scope.emails;
		$scope.emails = undefined;
		if($scope.validateEmails(emails))
		{
			console.log(emails);
			$http.get('../users/invite.json?t=free&e=' + emails).success(function(data) {
				console.log(data);
			});
		}
	}
	$scope.validateEmails = function(emails){
		var valid_emails = true;
		if(emails != undefined)
		{
			emails = emails.replace(/ /g,'');
			emails_arr = emails.split(",");
			for(var index = 0; index < emails_arr.length; index++)
			{
				if($scope.validateEmail(emails_arr[index]) == false)
				{
					valid_emails = false;
					break;
				}
			}
		}
		else
			valid_emails = false;
		return valid_emails;
	}
	$scope.validateEmail = function(email) { 
		var re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
		return re.test(email);
	}
});
app.controller("DocumentSignController", function($scope, $http){
	$scope.sign = function(){
		$('#sign_loading').attr('style', 'display: block;text-align:center;margin-left:auto;margin-right:auto;');
		$http.get('../documents/sign/' + $scope.document_id + '.json').success(function(data) {
			console.log(data);
			$('#modal-panel-participant-sign').modal('hide');
			$('#modal-panel-user-sign-ok').modal('show');
		});
	}
});
app.controller("DocumentOptionsController", function($scope, $http){
	$scope.destroy = function(){
		$http.get('../documents/destroy/' + $scope.document_id + '.json').success(function(data) {
			console.log(data);
			window.location.href = "http://firmaexpress.com"
		});
	}
});