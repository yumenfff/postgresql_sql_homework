with recursive
    all_subordinates as ( select e.EmployeeID as manager_id, e.EmployeeID as subordinate_id
                          from Employees e

                          union all

                          select a.manager_id, e.EmployeeID
                          from Employees e
                                   join all_subordinates a on e.ManagerID = a.subordinate_id ),
    total_subordinates as ( select manager_id, count(*) - 1 as total_subordinates
                            from all_subordinates
                            group by manager_id ),
    direct_subordinates as ( select ManagerID, count(*) as direct_count
                             from Employees
                             where ManagerID is not null
                             group by ManagerID ),
    employee_projects as ( select DepartmentID, string_agg(ProjectName, ', ' order by ProjectName) as ProjectNames
                           from Projects
                           group by DepartmentID ),
    employee_tasks as ( select AssignedTo, string_agg(TaskName, ', ' order by TaskName) as TaskNames
                        from Tasks
                        group by AssignedTo )
select e.EmployeeID,
       e.Name as EmployeeName,
       e.ManagerID,
       d.DepartmentName,
       r.RoleName,
       ep.ProjectNames,
       et.TaskNames,
       ts.total_subordinates
from Employees e
         join Roles r on e.RoleID = r.RoleID
         join Departments d on e.DepartmentID = d.DepartmentID
         join total_subordinates ts on e.EmployeeID = ts.manager_id
         join direct_subordinates ds on e.EmployeeID = ds.ManagerID
         left join employee_projects ep on e.DepartmentID = ep.DepartmentID
         left join employee_tasks et on e.EmployeeID = et.AssignedTo
where r.RoleName = 'Менеджер'
  and ds.direct_count > 0
order by e.Name;
